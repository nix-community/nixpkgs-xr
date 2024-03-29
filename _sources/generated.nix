# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  index_camera_passthrough = {
    pname = "index_camera_passthrough";
    version = "d102ddb0ff70126483d91a7a87d987065d45c06b";
    src = fetchgit {
      url = "https://github.com/yshui/index_camera_passthrough.git";
      rev = "d102ddb0ff70126483d91a7a87d987065d45c06b";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-OA1YuFPoeJzQ7ZdhLKzoAR9hY64OOrpBmG23u9YqWQg=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./index_camera_passthrough-d102ddb0ff70126483d91a7a87d987065d45c06b/Cargo.lock;
      outputHashes = {
        "vulkano-0.34.0" = "sha256-co2+rDJ1jOee36x9FcLX2Pze9ZItBYHq9/pEq0NhcpY=";
      };
    };
    date = "2024-03-08";
  };
  monado = {
    pname = "monado";
    version = "f62bc56d006169083991754fe4b15cf173c9884c";
    src = fetchgit {
      url = "https://gitlab.freedesktop.org/monado/monado.git";
      rev = "f62bc56d006169083991754fe4b15cf173c9884c";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-VeKbglLXD4NkVvvtVrS3lr1cHimzJvHLmj3UEYBWoQ4=";
    };
    date = "2024-03-27";
  };
  opencomposite = {
    pname = "opencomposite";
    version = "1bfdf67358add5f573efedbec1fa65d18b790e0e";
    src = fetchgit {
      url = "https://gitlab.com/znixian/OpenOVR.git";
      rev = "1bfdf67358add5f573efedbec1fa65d18b790e0e";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-qF5oMI9B5a1oE2gQb/scbom/39Efccja0pTPHHaHMA8=";
    };
    date = "2024-03-04";
  };
  wlx-overlay-s = {
    pname = "wlx-overlay-s";
    version = "5ab506e1920f0d6630a1452ca9e59d0683de7830";
    src = fetchgit {
      url = "https://github.com/galister/wlx-overlay-s.git";
      rev = "5ab506e1920f0d6630a1452ca9e59d0683de7830";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sha256 = "sha256-5uvdLBUnc8ba6b/dJNWsuqjnbbidaCcqgvSafFEXaMU=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./wlx-overlay-s-5ab506e1920f0d6630a1452ca9e59d0683de7830/Cargo.lock;
      outputHashes = {
        "wlx-capture-0.3.1" = "sha256-kK3OQMdIqCLZlgZuevNtfMDmpR8J2DFFD8jRHHWAvSA=";
        "vulkano-0.34.0" = "sha256-0ZIxU2oItT35IFnS0YTVNmM775x21gXOvaahg/B9sj8=";
        "ovr_overlay-0.0.0" = "sha256-b2sGzBOB2aNNJ0dsDBjgV2jH3ROO/Cdu8AIHPSXMCPg=";
      };
    };
    date = "2024-03-23";
  };
}
