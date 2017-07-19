# japan-masters-swimming

## Badges

[![Build Status](https://travis-ci.org/supercaracal/japan-masters-swimming.svg?branch=master)](https://travis-ci.org/supercaracal/japan-masters-swimming)
[![Code Climate](https://codeclimate.com/github/supercaracal/japan-masters-swimming/badges/gpa.svg)](https://codeclimate.com/github/supercaracal/japan-masters-swimming)
[![Test Coverage](https://codeclimate.com/github/supercaracal/japan-masters-swimming/badges/coverage.svg)](https://codeclimate.com/github/supercaracal/japan-masters-swimming/coverage)
[![Issue Count](https://codeclimate.com/github/supercaracal/japan-masters-swimming/badges/issue_count.svg)](https://codeclimate.com/github/supercaracal/japan-masters-swimming/issues)

## What's this?

These are results of the Japan Masters Swimming Championships. It is scraped from Japan Masters Swimming Association's site.

## Sources

* [第29回日本マスターズ水泳選手権大会 2012年7月13日(金)から7月16日(月) 会場:千葉県国際総合水泳場 50m](http://www.tdsystem.co.jp/JAPANMASTERS2012/PRO.HTM)
* [第30回日本マスターズ水泳選手権大会 2013年7月12日(金)から7月15日(月) 会場:日本ガイシアリーナ 50m](http://www.tdsystem.co.jp/JapanMasters/2013/PRO.HTM)
* [第31回日本マスターズ水泳選手権大会 2014年7月18日(金)から7月21日(月) 会場:横浜国際プール 50m](http://www.tdsystem.co.jp/Masters/JM2014/PRO.HTM)
* [第32回日本マスターズ水泳選手権大会 2015年7月16日(木)から7月20日(月) 会場:東京辰巳国際水泳場 50m](http://www.tdsystem.co.jp/Masters/JM2015/PRO.HTM)
* [第33回日本マスターズ水泳選手権大会 2016年7月14日(木)から7月18日(月) 会場:千葉県国際総合水泳場 50m](http://www.tdsystem.co.jp/Masters/JM2016/PRO.HTM)
* [第34回日本マスターズ水泳選手権大会 2017年7月14日(金)から7月17日(月) 会場:東和薬品RACTABドーム 50m](http://www.tdsystem.co.jp/Masters/JM2017/PRO.HTM)

## Development

```
$ git clone git@github.com:supercaracal/japan-masters-swimming.git
```

```
$ bin/bundle install --path=.bundle
```

```
$ bin/rails db:setup
```

```
$ bin/rails s -b 0.0.0.0
```

```
$ bin/guard
```

## Import Task

```
$ bin/rake import:results[year,page]
```
