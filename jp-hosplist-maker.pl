
#届出受理医療機関名簿から医療機関名簿を作成するPerl Script
#2010.08.17 Hiromasa Horiguchi

#/usr/bin/perl

use utf8; 
use open IO => ":encoding(cp932)"; 
binmode STDIN => ":encoding(cp932)"; 
binmode STDOUT => ":encoding(cp932)"; 
binmode STDERR => ":encoding(cp932)"; 
use Encode; 


print system("dir /b /od *.txt >filename.data");

$outfile1 = '> data1.tsv';
$outfile2 = '> data2.tsv';
$outfile3 = '> data3.tsv';

open  ( FN ," < filename.data" )|| die "ファイルを開けません :$!\n";

open ( REC  ,encode("cp932", $outfile1 ))|| die "ファイルを開けません :$!\n";
open ( REC2 ,encode("cp932", $outfile2 ))|| die "ファイルを開けません :$!\n";
open ( REC3 ,encode("cp932", $outfile3 ))|| die "ファイルを開けません :$!\n";

	print REC  "No"."\t"."データ日"."\t"."保険区分"."\t"."都道府県"."\t"."保険医療機関コード"."\t"."施設名"."\t"."郵便番号"."\t"."住所"."\t"."病床数"."\t"."Phone"."\t"."FAX"."\n";
	print REC3 "No"."\t"."データ日"."\t"."保険区分"."\t"."都道府県"."\t"."保険医療機関コード"."\t"."届出区分"."\t"."受理番号"."\t"."受理日"."\n";

close (REC3);
close (REC2);
close (REC);

$outfile1 = '>'.$outfile1;
$outfile2 = '>'.$outfile2;
$outfile3 = '>'.$outfile3;

open ( REC ,encode("cp932",  $outfile1 ))|| die "ファイルを開けません :$!\n";
open ( REC2 ,encode("cp932", $outfile2 ))|| die "ファイルを開けません :$!\n";
open ( REC3 ,encode("cp932", $outfile3 ))|| die "ファイルを開けません :$!\n";

while ( $filenm =<FN>){

	chomp($filenm);
	$filein = $filenm;
	open ( RECE, "<:encoding(UTF-16LE)" ,encode("cp932",$filein ))|| die "ファイルを開けません :$!\n";
	print "処理中: ".$filenm."\n";

$firstck=0;
$n1=0;
$row12='';

while ( $line =<RECE> ){

					$line=~s/\x{2003}/　/g;
					$line=~s/\x{2212}/ー/g;
					$line=~s/\x{208b}/吉/g;
					$line=~s/\x{2082}/廣/g;
					$line=~s/\x{2092}/辻/g;
					$line=~s/\x{feff}/\n/g;
					$line=~s/\r//;
					$line=~s/\n//g;
#					$line=~s/ //g;
					$line=~s/医療機関名称//g;
					$line=~s/医療機関所在地//g;
					$line=~s/開設者氏名//g;
					$line=~s/管理者氏名//g;
					$line=~s/電話番号\(ＦＡＸ番号\)//g;
					$line=~s/電話番号//g;
					$line=~s/病床数//g;
					$line=~s/全医療機関出力 //g;
					$line=~s/全医療機関出力//g;
					$line=~s/届出受理医療機関名簿//g;

		if ( $line=~/都道府県の境目/ ){
		$firstck=0;
		$line="";
		}


		if ( $line=~/\[/ ) {
		$row11=$line;
		$row11=~s/\[//g;
		$row11=~s/\]//g;
		$row11=~s/  /\t/;
		$row11=~s/ //g;
		$row11=~s/現在//g;
		$row11=~s/　/\t/;
		@data1=split(/　/, $row11);
		$row11=@data1[0];
		@data1=split(/\t/, $row11);
				}

	@data=split(/\t/, $line);

@data[0]=~s/ //g;
@data[1]=~s/ //g;
@data[2]=~s/ //g;
#@data[3]=~s/ //g;
@data[5]=~s/ //g;
@data[6]=~s/ //g;

		if (@data[1]=~/^[0-9]/ ){

			if ($firstck eq 1){
				if ($row12 eq '') { $row12=@data1[1];}
				print REC $row1."\t".@data1[0]."\t".$row12."\t".$row0."\t".$row2."\t".$row3."\t".$row4."\t".$row5."\t".$row7."\t".$row6."\n";

				$row7=~s/　{1,}/ /g;
				$row7=~s/[0-9]/ $&/;
				$row7=~s/ /\t/g;
				@data2=split(/\t/, $row7);
				$row13='';
				
				foreach (@data2){
					if ($_=~/^[0-9]/ ){
						print REC2 $row1."\t".@data1[0]."\t".$row12."\t".$row0."\t".$row2."\t".$row13."\t".$_."\n";
						$row13='';
					} elsif ($_ ne ''){
						$row13=$_;
					}
				}
				$row12=@data1[1];
			}
			$row1=$data[0];
			$row2=$data[1];
				$row2=~s/･//g;
				$row2=~s/\,//g;
				$row2=~s/-//g;
				$row2=~s/\.//g;
			$row3=$data[2];
			if (@data[3]=~/^〒/ ){
					$row4=$data[3];
					$row4=~s/〒//g;
					$row4=~s/ //g;
					$row5='';
				} else {
					$row4='';
					$row5=$data[3];
				}
			$row6='';
			$row7=$data[4];
			$row8=$data[5];
			$row9=$data[6];

##最初の医療機関から都道府県番号を取得（郵便番号上2ケタ利用）

			if ($firstck eq 0){
			 if ($row4=~/^0[4-9]/)	{$row0 = "01";} elsif 
			    ($row4=~/^00/)	{$row0 = "01";} elsif 
			    ($row4=~/^03/)	{$row0 = "02";} elsif 
			    ($row4=~/^02/)	{$row0 = "03";} elsif 
			    ($row4=~/^98/)	{$row0 = "04";} elsif 
			    ($row4=~/^01/)	{$row0 = "05";} elsif 
			    ($row4=~/^99/)	{$row0 = "06";} elsif 
			    ($row4=~/^96/)	{$row0 = "07";} elsif 
			    ($row4=~/^3[0-1]/)	{$row0 = "08";} elsif 
			    ($row4=~/^32/)	{$row0 = "09";} elsif 
			    ($row4=~/^37/)	{$row0 = "10";} elsif 
			    ($row4=~/^3[3-6]/)	{$row0 = "11";} elsif 
			    ($row4=~/^2[6-9]/)	{$row0 = "12";} elsif 
			    ($row4=~/^1/)	{$row0 = "13";} elsif 
			    ($row4=~/^2[1-5]/)	{$row0 = "14";} elsif 
			    ($row4=~/^9[4-5]/)	{$row0 = "15";} elsif 
			    ($row4=~/^93/)	{$row0 = "16";} elsif 
			    ($row4=~/^92/)	{$row0 = "17";} elsif 
			    ($row4=~/^91/)	{$row0 = "18";} elsif 
			    ($row4=~/^40/)	{$row0 = "19";} elsif 
			    ($row4=~/^3[8-9]/)	{$row0 = "20";} elsif 
			    ($row4=~/^50/)	{$row0 = "21";} elsif 
			    ($row4=~/^4[1-3]/)	{$row0 = "22";} elsif 
			    ($row4=~/^4[4-9]/)	{$row0 = "23";} elsif 
			    ($row4=~/^51/)	{$row0 = "24";} elsif 
			    ($row4=~/^52/)	{$row0 = "25";} elsif 
			    ($row4=~/^6[0-2]/)	{$row0 = "26";} elsif 
			    ($row4=~/^5[3-9]/)	{$row0 = "27";} elsif 
			    ($row4=~/^6[5-7]/)	{$row0 = "28";} elsif 
			    ($row4=~/^63/)	{$row0 = "29";} elsif 
			    ($row4=~/^64/)	{$row0 = "30";} elsif 
			    ($row4=~/^68/)	{$row0 = "31";} elsif 
			    ($row4=~/^69/)	{$row0 = "32";} elsif 
			    ($row4=~/^7[0-1]/)	{$row0 = "33";} elsif 
			    ($row4=~/^7[2-3]/)	{$row0 = "34";} elsif 
			    ($row4=~/^7[4-5]/)	{$row0 = "35";} elsif 
			    ($row4=~/^77/)	{$row0 = "36";} elsif 
			    ($row4=~/^76/)	{$row0 = "37";} elsif 
			    ($row4=~/^79/)	{$row0 = "38";} elsif 
			    ($row4=~/^78/)	{$row0 = "39";} elsif 
			    ($row4=~/^8[0-3]/)	{$row0 = "40";} elsif 
			    ($row4=~/^84/)	{$row0 = "41";} elsif 
			    ($row4=~/^85/)	{$row0 = "42";} elsif 
			    ($row4=~/^86/)	{$row0 = "43";} elsif 
			    ($row4=~/^87/)	{$row0 = "44";} elsif 
			    ($row4=~/^88/)	{$row0 = "45";} elsif 
			    ($row4=~/^89/)	{$row0 = "46";} elsif 
			    ($row4=~/^90/)	{$row0 = "47";} else 
								{$row0="00"}
		$firstck=1;
		$row4=$data[3];
		$row4=~s/〒//g;
		$row12=@data1[1];
					} 

## 医療機関コードを都道府県番号付きに変更
			$row2=$row0.$row2;



##2行目以降処理
		} else {
					$data[2]=~s/-{2,}//g;
			$row3=$row3.$data[2];
					$data[3]=~s/-{2,}//g;
				if ($data[3]=~/^[0-9]/) {
					$data[3]=~s/\)//g;
					$data[3]=~s/\s\(/\t/g;
					$data[3]=~s/\(//g;
				$row6=$data[3];
				} else{
				$data[3]=~s/\s//g;
				$row5=$row5.$data[3];
				}
					$data[4]=~s/-{2,}//g;
			$row7=$row7.$data[4];
					$data[5]=~s/-{2,}//g;
			$row8=$data[5];
					$data[6]=~s/-{2,}//g;
			$row9=$data[6];

		}

			if ($firstck eq 1){
			$row8=~s/受理番号//;
				if ($row8 ne ''){
				if ($row8=~/）/) {
					$row8=~s/（//;
					$row8=~s/）/\t/g;
					} else {
					$row8=$row8.'tub';
					$row8=~s/tub/\t/;
					}
			print REC3 $row1."\t".@data1[0]."\t".$row12."\t".$row0."\t".$row2."\t".$row8."\t".$row9."\n";

				}
			}
	}

			print REC $row1."\t".@data1[0]."\t".$row12."\t".$row0."\t".$row2."\t".$row3."\t".$row4."\t".$row5."\t".$row7."\t".$row6."\n";

close (RECE);
}
close (REC3);
close (REC2);
close (REC);

