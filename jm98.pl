#! /usr/bin/perl
#------------------------------------------------------------------------------ 
# 
# Filename:  ITM.pl
# 
#	Author£º Hao Lv, hlv@pku.edu.cn, Peking University
#	
#	Version£ºRev 1.0, April 27, 2013
#
# Function£ºused to collect the bitrate and PSNR of IVC (ISO/IEC JTC1/SC29 WG11 MPEG, Internet Video Coding) reference software ITM.
#
#	Revision History:
#		1.0	04/27/2013	Initial release. Use the command "glob" to ignore suffix of .txt file. For examlpe, we can use "PartyScene_832x480_50_1800" instead of "PartyScene_832x480_50_1800_QP46~46.txt" by using "glob".
#
#
#	Please report bugs, errors, etc.
#------------------------------------------------------------------------------

#use 5.016;#acquiescently "use strict;" #indicates that all variables must either be lexically scoped (using "my" or "state"), declared beforehand using "our", or explicitly qualified to say which package the global variable is in (using "::").
use 5.010;
use warnings;
use diagnostics;#warning info

###open file and read
#open my $read_rock_fh, '<', 'rocks.txt' or die "Could not open rock.txt:$!";
use autodie;
open my $write_fh, '>>', 'result.txt';

my @array = qw{ 
                Kimono_1920x1080_24_22
                Kimono_1920x1080_24_27
                Kimono_1920x1080_24_32
                Kimono_1920x1080_24_37
                
                ParkScene_1920x1080_24_22
                ParkScene_1920x1080_24_27
                ParkScene_1920x1080_24_32
                ParkScene_1920x1080_24_37
                
                Cactus_1920x1080_50_22
                Cactus_1920x1080_50_27
                Cactus_1920x1080_50_32
                Cactus_1920x1080_50_37
                
                BasketballDrive_1920x1080_50_22
                BasketballDrive_1920x1080_50_27
                BasketballDrive_1920x1080_50_32
                BasketballDrive_1920x1080_50_37
                
                BQTerrace_1920x1080_60_22
                BQTerrace_1920x1080_60_27
                BQTerrace_1920x1080_60_32
                BQTerrace_1920x1080_60_37
                            
                                
                BasketballDrill_832x480_50_22
                BasketballDrill_832x480_50_27
                BasketballDrill_832x480_50_32
                BasketballDrill_832x480_50_37
                
                BQMall_832x480_60_22
                BQMall_832x480_60_27
                BQMall_832x480_60_32
                BQMall_832x480_60_37
                
                PartyScene_832x480_50_22
                PartyScene_832x480_50_27
                PartyScene_832x480_50_32
                PartyScene_832x480_50_37
                
                RaceHorsesC_832x480_30_22
                RaceHorsesC_832x480_30_27
                RaceHorsesC_832x480_30_32
                RaceHorsesC_832x480_30_37
                
                
                BasketballPass_416x240_50_22
                BasketballPass_416x240_50_27
                BasketballPass_416x240_50_32
                BasketballPass_416x240_50_37
                    
                BQSquare_416x240_60_22
                BQSquare_416x240_60_27
                BQSquare_416x240_60_32
                BQSquare_416x240_60_37
                
                BlowingBubbles_416x240_50_22
                BlowingBubbles_416x240_50_27
                BlowingBubbles_416x240_50_32
                BlowingBubbles_416x240_50_37
                
                RaceHorses_416x240_30_22
                RaceHorses_416x240_30_27
                RaceHorses_416x240_30_32
                RaceHorses_416x240_30_37
                
                Vidyo1_1280x720_60_22
                Vidyo1_1280x720_60_27
                Vidyo1_1280x720_60_32
                Vidyo1_1280x720_60_37
                
                Vidyo3_1280x720_60_22
                Vidyo3_1280x720_60_27
                Vidyo3_1280x720_60_32
                Vidyo3_1280x720_60_37
                
                Vidyo4_1280x720_60_22
                Vidyo4_1280x720_60_27
                Vidyo4_1280x720_60_32
                Vidyo4_1280x720_60_37
                
                
                BasketballDrillText_832x480_50_22
                BasketballDrillText_832x480_50_27
                BasketballDrillText_832x480_50_32
                BasketballDrillText_832x480_50_37
                
                ChinaSpeed_1024x768_30_22
                ChinaSpeed_1024x768_30_27
                ChinaSpeed_1024x768_30_32
                ChinaSpeed_1024x768_30_37
                
                SlideEditing_1280x720_30_22
                SlideEditing_1280x720_30_27
                SlideEditing_1280x720_30_32
                SlideEditing_1280x720_30_37
                
                SlideShow_1280x720_20_22
                SlideShow_1280x720_20_27
                SlideShow_1280x720_20_32
                SlideShow_1280x720_20_37
                
              };  #all the files 
foreach $file (@array) 
{
	#the first way
	#open my $read_fh, '<', $file; 
	
	#the second way
	#my $file = glob $file;   
	#open my $read_fh, '<', $file;
	#print "begin read $file and write to result.txt!\n";
	
	#the third way, the same as the second way.
	open my $read_fh, '<', <$file*>;#glob
	printf "begin read %s and write to result.txt!\n",<$file*>;#using printf is better than print.
  my ($encoder_time, $bitrate, $psnrY, $psnrU, $psnrV);
  while(<$read_fh>)
   {
	   chomp;

	   if(/Total encoding time .+? ([0-9]+\.[0-9]+) sec/)#match "Total encoding time for the seq.  : 26254.724 sec "
	    {
		   #print $_;
		   #print $1;
		   $encoder_time = $1;
	    }
	  if(/SNR Y\(dB\) .+? ([0-9]+\.[0-9]+)/)#match "SNR Y(dB)                         : 38.01"
	    {
		   #print $1;
		   $psnrY = $1;
	    }
	  if(/SNR U\(dB\) .+? ([0-9]+\.[0-9]+)/)#match "SNR U(dB)                         : 39.19"
	    {
		   #print $1;
		   $psnrU = $1;
	    }
	  if(/SNR V\(dB\) .+? ([0-9]+\.[0-9]+)/)#match "SNR V(dB)                         : 41.51"
	    {
		   #print $1;
		   $psnrV = $1;
	    }
	  if(/Bit rate .+? ([0-9]+\.[0-9]+) .+? ([0-9]+\.[0-9]+)/)#match "Bit rate (kbit/s)  @ 30.00 Hz     : 6311.89"
	    {
		   #print $_;
		   #print $2; #$1 is 30.00 in "... 30.00 Hz ..."
		   $bitrate = $2;
	    }
	
   }
    print $write_fh $bitrate . " ";
	  print $write_fh $psnrY . " ";
    print $write_fh $psnrU . " ";
    print $write_fh $psnrV . " ";
    print $write_fh $encoder_time . " " . "\n";
   
   close $read_fh;
}
close $write_fh;



