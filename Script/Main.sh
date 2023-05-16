#!/bin/sh

sh Build.sh && sh UpdatePackageFile.sh && sh Git.sh && sh Release.sh
