#!/usr/bin/perl

#use strict;
package OpenTTD::OpenTTDRsyncSetup;

use lib '..';
use UpdateCommon qw(download_file unArchiveTo copyFile copyFolder moveFolder prepGameFolder);;
use File::Path qw(make_path);

my $gamename    = "$ARGV[0]";
my $platform    = "$ARGV[1]";
my $downloadurl = "$ARGV[2]";
my $outputdir   = "$gamename/done/$gamename";
my $workingdir  = "$gamename/working";
my $platformdir = "$workingdir/$gamename/$platform/";
my $basesetdir  = "$platformdir/baseset";

&prepGameFolder($basesetdir);
&prepGameFolder($outputdir);
&prepGameFolder($platformdir);

&copyFile("$gamename/openttd_launcher.sh",$platformdir,0766);
&copyFile("$gamename/openttd.cfg",$platformdir,0766);

&download_file("$downloadurl", "$workingdir/openttd.tar.gz");
&unArchiveTo("$workingdir/openttd.tar.gz","$workingdir");

#Todo, Can I do this in perl??
my $systemCommand = "mv -f $workingdir/openttd-*/* $platformdir";
my $exitStatus = system($systemCommand);

&copyFolder("$workingdir/$gamename",$outputdir);
