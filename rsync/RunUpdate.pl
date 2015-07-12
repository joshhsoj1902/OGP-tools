#!/usr/bin/perl

#use strict;
package RunUpdate;

use UpdateCommon qw(parse_game copyFolder setOwner);

my $GAME_LIST_FILE = "rsync_game_list.load";
my $RSYNC_DIR = "/home/ogpuser/games";
my $RSYNC_USER  = '500';
my $RSYNC_GROUP = 'users';

if ( @ARGV != 2 )
{
  die "Usage $0 [update|install] [all|<game_name>]";
  
}
my $firstParam  = uc $ARGV[0];
my $secondParam = uc $ARGV[1]; 
my $runMode     = "";

if (($firstParam eq "UPDATE") or ($firstParam eq "U")){
  $runMode = "U";
}elsif (($firstParam eq "INSTALL") or ($firstParam eq "I")){
  $runMode = "I";
}else{
  die "Invalid Runmode [update|install]";
}

my $theGame = $secondParam;

&processGames($theGame,$runMode);

#if ($runMode eq "U")
#{
#  &updateGame($updateThisGame);
#}


#&parse_game('rsync_game_list.load',1);


sub processGames {

  my $gameName = $_[0];
  my $runMode  = $_[1];

  my $parsedGameName    = "";
  my $parsedGameMod     = "";
  my $parsedVersion     = "";
  my $parsedPlatform    = "";
  my $parsedDownloadUrl = "";

  my $i = 1;
  my $gameFound = 0;

  while (1)
  {
    ($parsedGameName, $parsedGameMod, $parsedVersion, $parsedPlatform, $parsedDownloadUrl) 
      = parse_game($GAME_LIST_FILE,$i);

    chomp($parsedGameName);

    if ($parsedGameName eq ""){
      last;
    }
    if ((uc $gameName eq uc $parsedGameName) || (uc $gameName eq "ALL"))
    {
      if ($runMode eq "U" )
      {
        &updateGame($parsedGameName, $parsedGameMod, $parsedVersion, $parsedPlatform, $parsedDownloadUrl);
      } elsif ($runMode eq "I") {
        &installGame($parsedGameName);
      }

      $gameFound = 1;
    }

    $i +=1;
  }
  if ($gameFound = 0)
  {
    die "Game $gameName not found in $GAME_LIST_FILE";
  } 

}

sub updateGame {

  my $gamename    = $_[0];
  my $gamemod     = $_[1];
  my $version     = $_[2];
  my $platform    = $_[3];
  my $downloadurl = $_[4];

  print "=================\n";
  print "$gamename UPDATING \n";
  #print $gamename;
  #print $gamemod;
  #print $version;
  #print $platform;
  #print $downloadurl;

  chomp($gamename);

  if (-d $gamename) {
    @list = <$gamename/*RsyncSetup.pl>;

    my $gameScript = "$list[0]\n";

    chomp($gameScript);
    chomp($platform);
    chomp($downloadurl);

    local @ARGV = ($gamename, $platform, $downloadurl);

    system($^X, $gameScript, @ARGV);
  }else {
    print "\n\nNo folder found for \'$gamename\', Skipping update \n\n\n";
  }

  print "Done \n";
  print "=================\n";

}

sub installGame {

  my $gameName    = $_[0];

  if ($gameName ne "")
  {
    if (-d $gameName) {
      &setOwner("$RSYNC_USER", "$RSYNC_GROUP","$gameName/done");
      &copyFolder("$gameName/done", "$RSYNC_DIR");
      &setOwner("$RSYNC_USER", "$RSYNC_GROUP","$RSYNC_DIR/$gameName");
      print "=================\n";
      print "$gameName INSTALLED \n";
      print "=================\n";
    }else {
      print "\n\nNo folder found for \'$gamename\', Skipping Install \n\n\n";
    }
  }
}
