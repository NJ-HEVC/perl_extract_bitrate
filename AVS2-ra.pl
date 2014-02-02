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
open my $write_fh, '>>', 'result-ra.txt';

my @array = qw{ 
    
                pku_girls_3840x2160_50_27-ra
                pku_girls_3840x2160_50_32-ra
                pku_girls_3840x2160_50_38-ra
                pku_girls_3840x2160_50_45-ra

                pku_parkwalk_3840x2160_50_27-ra
                pku_parkwalk_3840x2160_50_32-ra
                pku_parkwalk_3840x2160_50_38-ra
                pku_parkwalk_3840x2160_50_45-ra

                Traffic_2560x1600_30_27-ra
                Traffic_2560x1600_30_32-ra
                Traffic_2560x1600_30_38-ra
                Traffic_2560x1600_30_45-ra


                beach_1920x1080_25_27-ra
                beach_1920x1080_25_32-ra
                beach_1920x1080_25_38-ra
                beach_1920x1080_25_45-ra

                taishan_1920x1080_25_27-ra
                taishan_1920x1080_25_32-ra
                taishan_1920x1080_25_38-ra
                taishan_1920x1080_25_45-ra

                Kimono_1920x1080_24_27-ra
                Kimono_1920x1080_24_32-ra
                Kimono_1920x1080_24_38-ra
                Kimono_1920x1080_24_45-ra

                Cactus_1920x1080_50_27-ra
                Cactus_1920x1080_50_32-ra
                Cactus_1920x1080_50_38-ra
                Cactus_1920x1080_50_45-ra
                
                BasketballDrive_1920x1080_50_27-ra
                BasketballDrive_1920x1080_50_32-ra
                BasketballDrive_1920x1080_50_38-ra
                BasketballDrive_1920x1080_50_45-ra
                            
                                
                BasketballDrill_832x480_50_27-ra
                BasketballDrill_832x480_50_32-ra
                BasketballDrill_832x480_50_38-ra
                BasketballDrill_832x480_50_45-ra
                
                BQMall_832x480_60_27-ra
                BQMall_832x480_60_32-ra
                BQMall_832x480_60_38-ra
                BQMall_832x480_60_45-ra
                
                PartyScene_832x480_50_27-ra
                PartyScene_832x480_50_32-ra
                PartyScene_832x480_50_38-ra
                PartyScene_832x480_50_45-ra
                
                RaceHorsesC_832x480_30_27-ra
                RaceHorsesC_832x480_30_32-ra
                RaceHorsesC_832x480_30_38-ra
                RaceHorsesC_832x480_30_45-ra
                
                
                BasketballPass_416x240_50_27-ra
                BasketballPass_416x240_50_32-ra
                BasketballPass_416x240_50_38-ra
                BasketballPass_416x240_50_45-ra

                BQSquare_416x240_60_27-ra
                BQSquare_416x240_60_32-ra
                BQSquare_416x240_60_38-ra
                BQSquare_416x240_60_45-ra
                
                BlowingBubbles_416x240_50_27-ra
                BlowingBubbles_416x240_50_32-ra
                BlowingBubbles_416x240_50_38-ra
                BlowingBubbles_416x240_50_45-ra

                RaceHorses_416x240_30_27-ra
                RaceHorses_416x240_30_32-ra
                RaceHorses_416x240_30_38-ra
                RaceHorses_416x240_30_45-ra

                City_1280x720_60_27-ra
                City_1280x720_60_32-ra
                City_1280x720_60_38-ra
                City_1280x720_60_45-ra
                
                Crew_1280x720_60_27-ra
                Crew_1280x720_60_32-ra
                Crew_1280x720_60_38-ra
                Crew_1280x720_60_45-ra
                
                Vidyo1_1280x720_60_27-ra
                Vidyo1_1280x720_60_32-ra
                Vidyo1_1280x720_60_38-ra
                Vidyo1_1280x720_60_45-ra
                
                Vidyo3_1280x720_60_27-ra
                Vidyo3_1280x720_60_32-ra
                Vidyo3_1280x720_60_38-ra
                Vidyo3_1280x720_60_45-ra
                
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

#finish!
print "Press Enter to Continue";
my $nothingtodo=<>;

