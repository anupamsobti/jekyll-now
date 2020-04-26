#!/bin/bash
if [ $# -lt 1 ]
then
	echo "Syntax: ./get_new_post <post_name>"
	exit -1
fi
filename=`date +%Y-%m-%d`
echo "Generated _posts/$filename-$1.md"
touch _posts/$filename-$1.md
echo "
---
title: 
author: anupamsobti
layout: post
image:
featured:
hidden:
categories:
	-
tags:
	- 
---" >> _posts/$filename-$1.md
