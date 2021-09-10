#!/bin/sh -l

cp -p $(find process.env.SOURCE_FOLDER -name process.env.CONTENTS) process.env.TARGET_FOLDER
