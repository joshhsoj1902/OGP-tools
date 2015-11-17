#!/usr/bin/perl

#use strict;
package UpdateCommon;

use File::Path qw(make_path remove_tree);
use LWP::Simple;
use Time::localtime;
use File::stat;
require HTTP::Date;
require LWP::UserAgent;
require Date::Parse;
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME} = 0;
use Archive::Extract;
use File::Copy qw(copy);
use File::Copy::Recursive qw(dircopy dirmove);
use File::Basename;

use parent 'Exporter';
our @EXPORT_OK = qw(parse_game download_file unArchiveTo copyFile copyFolder moveFolder prepGameFolder setOwner);

sub parse_game {

  my ($filename)    = $_[0];
  my ($line_number) = $_[1];

  # use the perl open function to open the file
  open(FILE, $filename) or die "Could not read from $filename, program halting.";

  my $i = 1;

  my $gamename    = "";
  my $gamemod     = "";
  my $version     = "";
  my $platform    = "";
  my $downloadurl = "";

  # loop through each line in the file
  # with the typical "perl file while" loop
  while(<FILE>)
  {
    # get rid of the pesky newline character
    chomp;

    if ($i == $line_number){
      # read the fields in the current line into an array
      @fields = split('\|', $_);

      # print the first field
      $gamename    = "$fields[0]\n";
      $gamemod     = "$fields[1]\n";
      $version     = "$fields[2]\n";
      $platform    = "$fields[3]\n";
      $downloadurl = "$fields[4]\n";
      last;
    }
    $i = $i + 1;
  }
  close FILE;
  return ($gamename,$gamemod,$version,$platform,$downloadurl);
}

sub prepGameFolder {

  my ($folder) = $_[0];

  if ($folder eq "")
  {
    die "Folder Path Empty, Can't Clean";
  }else {
    remove_tree($folder);
    make_path($folder);
  }

}

sub download_file {

  my ($downloadurl) = $_[0];
  my ($outFileName) = $_[1];

  my $lastChecked = "";
  if (-e $outFileName) {
    $lastChecked = ctime( stat($outFileName)->ctime );
  } else{
    $lastChecked = '2000-01-01';
  }

  print "Asking if file changed...\n";
  my $ua = LWP::UserAgent->new;
  $ua->default_header('If-Modified-Since' => HTTP::Date::time2str(Date::Parse::str2time($lastChecked)));

  my $response = $ua->get($downloadurl);

  if ($response->code == 304) {
      print "Skipping Download, No changes to $downloadurl since $lastChecked.\n";
  } elsif ($response->is_success) {
      print "Downloading File.\n";
      open my $outFile, '>', $outFileName or die "Failed opening $outFileName: $!";
      print $outFile $response->content;
      close $outFile;
  } else {
      print "Response was error " . $response->code . ": '" . $response->status_line . "'\n";
  }

}

sub unArchiveTo {

  my ($zipfile)   = $_[0];
  my ($outputdir) = $_[1];

  my $x = Archive::Extract->new( archive => "$zipfile");
  $x->extract( to => $outputdir ) or die $x->error;
}

sub copyFile {

  my ($sourceFile)      = $_[0];
  my ($destinationDir)  = $_[1];
  my ($filePermissions) = $_[2];

  @files = glob("$sourceFile");

  foreach (@files) {
    my $baseName = basename("$_");
    copy("$_","$destinationDir/.");

    if ($filePermissions ne ""){
      chmod $filePermissions, "$destinationDir/$baseName";
    }
  }
  #copy "$sourceDir/$sourceFile", "$destinationDir";
  #chmod $filePermissions, "$destinationDir/$sourceFile";

}

sub copyFolder {

  my ($sourceDir)       = $_[0];
  my ($destinationDir)  = $_[1];

  dircopy("$sourceDir", "$destinationDir");
}

sub moveFolder {

  my ($sourceDir)       = $_[0];
  my ($destinationDir)  = $_[1];

  dirmove("$sourceDir","$destinationDir")

}

sub setOwner {

  my $userName  = $_[0];
  my $groupName = $_[1];
  my $fileName  = $_[2];

  #my $uid = getpwnam $userName;
  #my $gid = getgrnam $groupName;
  #chown $uid, $gid, $fileName;
  my $systemCommand = "/bin/chown -R $userName:$groupName $fileName";
  my $exitStatus = system($systemCommand);

}

1;

