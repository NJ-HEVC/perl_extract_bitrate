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
                Traffic_2560x1600_30_31
                Traffic_2560x1600_30_36
                Traffic_2560x1600_30_39
                Traffic_2560x1600_30_45
                
                PeopleOnStreet_2560x1600_30_33
                PeopleOnStreet_2560x1600_30_40
                PeopleOnStreet_2560x1600_30_45
                PeopleOnStreet_2560x1600_30_50
                
                
                Kimono_1920x1080_24_31
                Kimono_1920x1080_24_38
                Kimono_1920x1080_24_45
                Kimono_1920x1080_24_48
                
                ParkScene_1920x1080_24_32
                ParkScene_1920x1080_24_37
                ParkScene_1920x1080_24_42
                ParkScene_1920x1080_24_45
                
                
                BasketballDrill_832x480_50_32
                BasketballDrill_832x480_50_38
                BasketballDrill_832x480_50_42
                BasketballDrill_832x480_50_45
                
                BQMall_832x480_60_33
                BQMall_832x480_60_38
                BQMall_832x480_60_44
                BQMall_832x480_60_47
                
                PartyScene_832x480_50_34
                PartyScene_832x480_50_38
                PartyScene_832x480_50_42
                PartyScene_832x480_50_47
                
                RaceHorses_832x480_30_34
                RaceHorses_832x480_30_38
                RaceHorses_832x480_30_43
                RaceHorses_832x480_30_48
                
                
                BasketballPass_416x240_50_32
                BasketballPass_416x240_50_38
                BasketballPass_416x240_50_42
                BasketballPass_416x240_50_46
                    
                BQSquare_416x240_60_34
                BQSquare_416x240_60_38
                BQSquare_416x240_60_40
                BQSquare_416x240_60_45
                
                BlowingBubbles_416x240_50_29
                BlowingBubbles_416x240_50_32
                BlowingBubbles_416x240_50_37
                BlowingBubbles_416x240_50_42
                
                RaceHorses_416x240_30_34
                RaceHorses_416x240_30_38
                RaceHorses_416x240_30_40
                RaceHorses_416x240_30_45
                
                
                FourPeople_1280x720_60_30
                FourPeople_1280x720_60_34
                FourPeople_1280x720_60_37
                FourPeople_1280x720_60_43
                
                Johnny_1280x720_60_30
                Johnny_1280x720_60_34
                Johnny_1280x720_60_37
                Johnny_1280x720_60_43
                
                KristenAndSara_1280x720_60_30
                KristenAndSara_1280x720_60_34
                KristenAndSara_1280x720_60_37
                KristenAndSara_1280x720_60_43
                
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



