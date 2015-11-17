#!/usr/bin/perl

#use strict;
package Terraria::TerrariaTShockRsyncSetup;

use lib '..';
use UpdateCommon qw(download_file unArchiveTo copyFile copyFolder prepGameFolder);;
use File::Path qw(make_path);

my $gamename    = "$ARGV[0]";
my $platform    = "$ARGV[1]";
my $downloadurl = "$ARGV[2]";
my $outputdir   = "$gamename/done/$gamename";
my $workingdir  = "$gamename/working";
my $platformdir = "$workingdir/$gamename/$platform/";

&prepGameFolder($outputdir);
&prepGameFolder($platformdir);

&download_file("$downloadurl", "$workingdir/$gamename.zip");
&unArchiveTo("$workingdir/$gamename.zip","$platformdir");

&copyFile("$gamename/terraria_tshock_launcher.sh",$platformdir,0766);
&make_path("$platformdir/Worlds");

&copyFolder("$workingdir/$gamename",$outputdir);
