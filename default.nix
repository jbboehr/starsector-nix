{
    system ? builtins.currentSystem,
    pkgs ? import <nixpkgs> { inherit system; },
    starsector ? pkgs.fetchzip {
        url = "https://s3.amazonaws.com/fractalsoftworks/starsector/starsector_linux-0.9.1a-RC8.zip";
        sha256 = "08x6sl4cbb4ryfdgf1bh74zbkg65p0cssyhsi9j1yrvkd9zjw274";
    }
}:

let
    xorgDeps = pkgs: with pkgs.xorg; [
        libX11 libXrender libXrandr libxcb libXmu libpthreadstubs libXext libXdmcp
        libXxf86vm libXinerama libSM libXv libXaw libXi libXcursor libXcomposite
        libXtst
    ];
    bash = pkgs.bash;
in

pkgs.buildFHSUserEnv {
    name = "starsector";
    multiPkgs = pkgs: with pkgs; [
        libglvnd
    ] ++ xorgDeps pkgs;
    runScript = "${bash}/bin/bash ${./starsector.sh} ${starsector}";
}
