#!/usr/bin/perl

#use strict;
package OpenTTD::OpenTTDOpenGFXRsyncSetup;

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

#&prepGameFolder($outputdir);
#&prepGameFolder("$basesetdir");

&download_file("$downloadurl", "$workingdir/opengfx.zip");

#My unAchive doesn't like this file...
my $systemCommand = "unzip -o $workingdir/opengfx.zip -d $workingdir; 
                     tar -xvf $workingdir/opengfx*.tar -C $basesetdir/";
my $exitStatus = system($systemCommand);

#&unArchiveTo("$workingdir/opengfx.zip","$workingdir");

#Todo, Can I do this in perl??
my $systemCommand = "mv -f $basesetdir/opengfx-* $basesetdir/opengfx";
my $exitStatus = system($systemCommand);

&copyFolder("$workingdir/$gamename",$outputdir);
