#!/usr/bin/env bash

cd $1

starsector_data=${XDG_DATA_HOME:-$HOME/.local/share}/starsector
starsector_cache=${XDG_CACHE_HOME:-$HOME/.cache}/starsector
starsector_saves=${starsector_data}/saves
starsector_screenshots=${starsector_data}/screenshots
starsector_logs=${starsector_cache}/logs
starsector_mods=${starsector_data}/mods

mkdir -p ${starsector_saves} ${starsector_screenshots} ${starsector_logs} ${starsector_mods}

./jre_linux/bin/java -server \
    -XX:CompilerThreadPriority=1 \
    -XX:+CompilerThreadHintNoPreempt \
    -Djava.library.path=./native/linux \
    -Xms1536m \
    -Xmx1536m \
    -Xss1024k \
    -classpath janino.jar:commons-compiler.jar:commons-compiler-jdk.jar:starfarer.api.jar:starfarer_obf.jar:jogg-0.0.7.jar:jorbis-0.0.15.jar:json.jar:lwjgl.jar:jinput.jar:log4j-1.2.9.jar:lwjgl_util.jar:fs.sound_obf.jar:fs.common_obf.jar:xstream-1.4.10.jar \
    -Dcom.fs.starfarer.settings.paths.saves=${starsector_saves} \
    -Dcom.fs.starfarer.settings.paths.screenshots=${starsector_screenshots} \
    -Dcom.fs.starfarer.settings.paths.mods=${starsector_mods} \
    -Dcom.fs.starfarer.settings.paths.logs=${starsector_logs} \
    com.fs.starfarer.StarfarerLauncher
