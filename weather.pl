#!/usr/bin/perl
###########
#
use strict;
use LWP::Simple;

my $city = "中山";
my $wid = "2161664"; 
my $url = "http://weather.yahooapis.com/forecastrss?w=$wid&u=c";
# Debugging - Comment out when not debugging #
#print $url;
my $data = get($url);
$data =~ m/<yweather\:condition\s+(.*?)\/>/ig;
$data = $1;

my %info ="";
my %text = (
    "0" => "龙卷风",
    "1" => "热带风暴",
    "2" => "飓风",
    "3" => "雷暴",
    "4" => "雷暴",
    "5" => "雨夹雪",
    "6" => "雨夹雪",
    "7" => "雨夹雪",
    "8" => "冻雨",
    "9" => "冻雨",
    "10" => "冻雨",
    "11" => "阵雨",
    "12" => "阵雨",
    "13" => "小雪",
    "14" => "阵雪",
    "15" => "风吹雪",
    "16" => "雪",
    "17" => "冰雹",
    "18" => "冻雨",
    "19" => "沙尘",
    "20" => "模糊",
    "21" => "薄雾",
    "22" => "污染",
    "23" => "坏天气",
    "24" => "有风",
    "25" => "冷",
    "26" => "阴天",
    "27" => "阴天",
    "28" => "多云",
    "29" => "多云",
    "30" => "多云",
    "31" => "晴",
    "32" => "睛",
    "33" => "睛",
    "34" => "睛",
    "35" => "雨夹冰雹",
    "36" => "热",
    "37" => "局部雷暴",
    "38" => "分散雷雨",
    "39" => "分散雷雨",
    "40" => "零星阵雨",
    "41" => "大雪",
    "42" => "零星阵雪",
    "43" => "大雪",
    "44" => "多云",
    "45" => "雷阵雨",
    "46" => "阵雨",
    "47" => "雷阵雨",
    "3200" => "未知",
);
my @condition = split /\"\s+/, $data;
foreach my $condition (@condition) {
    if ($condition =~ m/^(\w+)\s*=\s*\"(.*?)\s*$/) {
	$info{"$1"} = "$2";
    }
}

my $output = "$city\n$text{$info{code}}\nweather\/$info{code}\.png\n$info{temp}°C\n";
print $output;
