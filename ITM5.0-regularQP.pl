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
                Traffic_2560x1600_30_22.txt
                Traffic_2560x1600_30_27.txt
                Traffic_2560x1600_30_32.txt
                Traffic_2560x1600_30_37.txt
                
                PeopleOnStreet_2560x1600_30_22.txt
                PeopleOnStreet_2560x1600_30_27.txt
                PeopleOnStreet_2560x1600_30_32.txt
                PeopleOnStreet_2560x1600_30_37.txt
                
                
                Kimono_1920x1080_24_22.txt
                Kimono_1920x1080_24_27.txt
                Kimono_1920x1080_24_32.txt
                Kimono_1920x1080_24_37.txt
                
                ParkScene_1920x1080_24_22.txt
                ParkScene_1920x1080_24_27.txt
                ParkScene_1920x1080_24_32.txt
                ParkScene_1920x1080_24_37.txt
                
                BasketballDrill_832x480_50_22.txt
                BasketballDrill_832x480_50_27.txt
                BasketballDrill_832x480_50_32.txt
                BasketballDrill_832x480_50_37.txt
                
                BQMall_832x480_60_22.txt
                BQMall_832x480_60_27.txt
                BQMall_832x480_60_32.txt
                BQMall_832x480_60_37.txt
                
                PartyScene_832x480_50_22.txt
                PartyScene_832x480_50_27.txt
                PartyScene_832x480_50_32.txt
                PartyScene_832x480_50_37.txt
                
                RaceHorses_832x480_30_22.txt
                RaceHorses_832x480_30_27.txt
                RaceHorses_832x480_30_32.txt
                RaceHorses_832x480_30_37.txt
                
                
                BasketballPass_416x240_50_22.txt
                BasketballPass_416x240_50_27.txt
                BasketballPass_416x240_50_32.txt
                BasketballPass_416x240_50_37.txt
                    
                BQSquare_416x240_60_22.txt
                BQSquare_416x240_60_27.txt
                BQSquare_416x240_60_32.txt
                BQSquare_416x240_60_37.txt
                
                BlowingBubbles_416x240_50_22.txt
                BlowingBubbles_416x240_50_27.txt
                BlowingBubbles_416x240_50_32.txt
                BlowingBubbles_416x240_50_37.txt
                
                RaceHorses_416x240_30_22.txt
                RaceHorses_416x240_30_27.txt
                RaceHorses_416x240_30_32.txt
                RaceHorses_416x240_30_37.txt
                
                FourPeople_1280x720_60_22.txt
                FourPeople_1280x720_60_27.txt
                FourPeople_1280x720_60_32.txt
                FourPeople_1280x720_60_37.txt
                
                Johnny_1280x720_60_22.txt
                Johnny_1280x720_60_27.txt
                Johnny_1280x720_60_32.txt
                Johnny_1280x720_60_37.txt
                
                KristenAndSara_1280x720_60_22.txt
                KristenAndSara_1280x720_60_27.txt
                KristenAndSara_1280x720_60_32.txt
                KristenAndSara_1280x720_60_37.txt
                
                
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



