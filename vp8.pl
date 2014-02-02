#! /usr/bin/perl
#------------------------------------------------------------------------------ 
# 
# Filename:  vp8.pl
# 
#	Author£º Hao Lv, hlv@pku.edu.cn, Peking University
#	
#	Version£ºRev 1.1, March 31, 2013
#
# Function£ºused for vp8.
#
#	Revision History:
#		1.0	03/21/2013	Initial release.
#   1.1 03/31/2013  Use the command "glob" to ignore suffix of .txt file. For examlpe, we can use "PartyScene_832x480_50_1800" instead of "PartyScene_832x480_50_1800_QP46~46.txt" by using "glob".
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
#open my $read_fh, '<', 'RaceHorses_832x480_30_765.txt';
open my $write_fh, '>>', 'result.txt';

my @array = qw{ 
                Traffic_2560x1600_30_7800
                Traffic_2560x1600_30_5000
                Traffic_2560x1600_30_2900
                Traffic_2560x1600_30_1800
                
                PeopleOnStreet_2560x1600_30_18500
                PeopleOnStreet_2560x1600_30_11800
                PeopleOnStreet_2560x1600_30_8600
                PeopleOnStreet_2560x1600_30_5700
                
                
                Kimono_1920x1080_24_3700
                Kimono_1920x1080_24_2400
                Kimono_1920x1080_24_1400
                Kimono_1920x1080_24_1000
                
                ParkScene_1920x1080_24_4000
                ParkScene_1920x1080_24_2500
                ParkScene_1920x1080_24_1600
                ParkScene_1920x1080_24_1100
                
                
                BasketballDrill_832x480_50_2600
                BasketballDrill_832x480_50_1700
                BasketballDrill_832x480_50_1100
                BasketballDrill_832x480_50_760
                
                BQMall_832x480_60_2600
                BQMall_832x480_60_1700
                BQMall_832x480_60_1000
                BQMall_832x480_60_720
                
                PartyScene_832x480_50_3500
                PartyScene_832x480_50_2500
                PartyScene_832x480_50_1800
                PartyScene_832x480_50_740
                
                RaceHorses_832x480_30_2600
                RaceHorses_832x480_30_1800
                RaceHorses_832x480_30_1200
                RaceHorses_832x480_30_765
                
                
                BasketballPass_416x240_50_1100
                BasketballPass_416x240_50_670
                BasketballPass_416x240_50_450
                BasketballPass_416x240_50_310
                    
                BQSquare_416x240_60_2200
                BQSquare_416x240_60_1200
                BQSquare_416x240_60_550
                BQSquare_416x240_60_320
                
                BlowingBubbles_416x240_50_880
                BlowingBubbles_416x240_50_540
                BlowingBubbles_416x240_50_320
                BlowingBubbles_416x240_50_225
                
                RaceHorses_416x240_30_810
                RaceHorses_416x240_30_530
                RaceHorses_416x240_30_400
                RaceHorses_416x240_30_265
                
                
                FourPeople_1280x720_60_1619
                FourPeople_1280x720_60_1062
                FourPeople_1280x720_60_726
                FourPeople_1280x720_60_443
                
                Johnny_1280x720_60_1710
                Johnny_1280x720_60_900
                Johnny_1280x720_60_554
                Johnny_1280x720_60_372
                
                KristenAndSara_1280x720_60_1394
                KristenAndSara_1280x720_60_887
                KristenAndSara_1280x720_60_603
                KristenAndSara_1280x720_60_377
                
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
  while(<$read_fh>)
   {
	   chomp;
	   if(/([0-9]+)b\/s/)#match "000b/s"
	    {
		   #print $1;
	     print $write_fh $1/1000;
	     print $write_fh " ";
	    }
	  
	   if(/(Y\/U\/V\)\s? ([0-9]+\.[0-9]+\s?) ([0-9]+\.[0-9]+\s?) ([0-9]+\.[0-9]+\s?) ([0-9]+\.[0-9]+\s?) ([0-9]+\.[0-9]+\s?))/x)
	    {
	      #print $write_fh $1;
	      print $write_fh $4;
	      print $write_fh $5;
	      print $write_fh $6;
	      print $write_fh "\n";
	    }
	  
	#if(/Y\/U\/V\)\s? [0-9]+\.[0-9]+\s? [0-9]+\.[0-9]+\s? ([0-9]+\.[0-9]+\s?)\1\1$/x)#match "31.004 34.980 36.196",$ means the end! space(\s) is 0 or >0
	#{
	#	print "catch!";
	#  print $write_fh $1;
	#}
	
   }
   close $read_fh;
}
close $write_fh;



