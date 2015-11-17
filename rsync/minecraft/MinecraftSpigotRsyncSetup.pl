#!/usr/bin/perl

#use strict;
package Minecraft::MinecraftRsyncSetup;

use lib '..';
use UpdateCommon qw(download_file unArchiveTo copyFile copyFolder prepGameFolder);;
use File::Path qw(make_path);

my $gamename    = "$ARGV[0]";
my $platform    = "$ARGV[1]";
my $downloadurl = "$ARGV[2]";
my $outputdir   = "$gamename/done/$gamename";
#my $outputdir   = "$gamename/done/minecraft";
my $workingdir  = "$gamename/working";
my $platformdir = "$workingdir/$gamename/$platform/";

&prepGameFolder($outputdir);
&prepGameFolder($platformdir);

&download_file("$downloadurl", "$workingdir/BuildTools.jar");

print "\n\n======================\n";
print "This may take awhile...\n";
print "\n=======================\n";
sleep 5;

my $systemCommand = "cd $workingdir; java -jar BuildTools.jar";
my $exitStatus = system($systemCommand);

if ($exitStatus == 0) {

  &copyFile("$workingdir/spigot-*jar",$platformdir,0766);
  &copyFile("$workingdir/craftbukkit-*jar",$platformdir,0766);

  @files = glob("$platformdir/spigot-*jar");
  foreach (@files) {
    link("$_","$platformdir/spigot.jar");
  }

  @files = glob("$platformdir/craftbukkit-*jar");
  foreach (@files) {
    link("$_","$platformdir/craftbukkit.jar");
  }

  &copyFolder("$workingdir/$gamename",$outputdir);
}else {
  print "\n\n\n*************************************************\n";
  print "Build Failed \n\n";
  print "If it says you ran our of heap space you need more RAM. \n";
  print "Otherwise you can try again and hope for the best \n\n";
  print "https://www.spigotmc.org/wiki/buildtools/";
}
