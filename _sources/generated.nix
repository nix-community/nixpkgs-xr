# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  eepyxr = {
    pname = "eepyxr";
    version = "b826495d60b297d4a7a38c3c10203c919209fc3d";
    src = fetchgit {
      url = "https://github.com/Beyley/eepyxr.git";
      rev = "b826495d60b297d4a7a38c3c10203c919209fc3d";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-eDGIE/Mbc+52qAqjU+N5yrR23BO7PXLJTsZFG66qoqE=";
    };
    date = "2025-03-09";
  };
  envision-unwrapped = {
    pname = "envision-unwrapped";
    version = "0a46a7d3329d86629d7562d9f5747da70973a338";
    src = fetchgit {
      url = "https://gitlab.com/gabmus/envision.git";
      rev = "0a46a7d3329d86629d7562d9f5747da70973a338";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-CwaOSn5MP3iL6fQIAqi+mIfpPColyYs1rUM2jtRECPQ=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./envision-unwrapped-0a46a7d3329d86629d7562d9f5747da70973a338/Cargo.lock;
      outputHashes = {
        
      };
    };
    date = "2025-07-22";
  };
  index_camera_passthrough = {
    pname = "index_camera_passthrough";
    version = "0d3ec30c5cd74e4a3df93d704ecf4a25136afd73";
    src = fetchgit {
      url = "https://github.com/yshui/index_camera_passthrough.git";
      rev = "0d3ec30c5cd74e4a3df93d704ecf4a25136afd73";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-jldpVWnpWEA3bi3lzmG94uCaoZuL+xhaEAtFiZrSGc4=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./index_camera_passthrough-0d3ec30c5cd74e4a3df93d704ecf4a25136afd73/Cargo.lock;
      outputHashes = {
        "vulkano-0.34.0" = "sha256-co2+rDJ1jOee36x9FcLX2Pze9ZItBYHq9/pEq0NhcpY=";
      };
    };
    date = "2024-07-25";
  };
  monado = {
    pname = "monado";
    version = "c3717b0b7c1913d0cb41d08cb1c9dd950034e78f";
    src = fetchgit {
      url = "https://gitlab.freedesktop.org/monado/monado.git";
      rev = "c3717b0b7c1913d0cb41d08cb1c9dd950034e78f";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-3bpkhY8iOsG6c96dQQPA/8EEfpHa6U9ZluZKTQt9WLM=";
    };
    date = "2025-07-28";
  };
  opencomposite = {
    pname = "opencomposite";
    version = "cff07db75c4823afe93ed7027b03d5f7bc86f164";
    src = fetchgit {
      url = "https://gitlab.com/znixian/OpenOVR.git";
      rev = "cff07db75c4823afe93ed7027b03d5f7bc86f164";
      fetchSubmodules = true;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-nie+8g/P9aZYimuLJxrzN+frfA772VyPDf2ThyguqBM=";
    };
    date = "2025-07-21";
  };
  vapor = {
    pname = "vapor";
    version = "6d273cb6c7db0847daee1276be20886e6ff515ae";
    src = fetchgit {
      url = "https://github.com/micheal65536/VapoR.git";
      rev = "6d273cb6c7db0847daee1276be20886e6ff515ae";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-Ul7TBMyWnvsEIdaA0gEKiB5SNoiOSrcF937lkuZPUEg=";
    };
    date = "2025-05-27";
  };
  wayvr-dashboard = {
    pname = "wayvr-dashboard";
    version = "dad0b13389def4b6e8b8cdf212bcfcd314f19472";
    src = fetchgit {
      url = "https://github.com/olekolek1000/wayvr-dashboard";
      rev = "dad0b13389def4b6e8b8cdf212bcfcd314f19472";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-8lNkpGAV1mTj2M3wgDpjQwZm10RtBGsvURqlPULY4RA=";
    };
    cargoLock."src-tauri/Cargo.lock" = {
      lockFile = ./wayvr-dashboard-dad0b13389def4b6e8b8cdf212bcfcd314f19472/src-tauri/Cargo.lock;
      outputHashes = {
        "keyvalues-parser-0.2.0" = "sha256-LT+WHhan/USzW0EOiuIBPG5j1r9qL4n7Z7ESDxO1xQQ=";
        "libmonado-1.3.1" = "sha256-HYYfpYhyo5VmbUdwMTJuAR+2dnMITIGZIPGX9Qsnc/g=";
        "wayvr_ipc-0.1.0" = "sha256-ieQaY08Ogl/F3t/p825LBp1lAO3SWH1F8206IPXEgTc=";
      };
    };
    date = "2025-07-13";
  };
  wivrn = {
    pname = "wivrn";
    version = "b72554ea027fd8f973f3242adb829fc0e56c0306";
    src = fetchFromGitHub {
      owner = "WiVRn";
      repo = "WiVRn";
      rev = "b72554ea027fd8f973f3242adb829fc0e56c0306";
      fetchSubmodules = false;
      sha256 = "sha256-BE9LF4q8VU8qfQsxbzJvW6vmSPRvz+zPkfIHnyUTlTo=";
    };
    date = "2025-07-28";
  };
  wivrn-monado = {
    pname = "wivrn-monado";
    version = "2bf7f5c14b947ab3528e37551eb49753fe982dcb";
    src = fetchgit {
      url = "https://gitlab.freedesktop.org/monado/monado.git";
      rev = "2bf7f5c14b947ab3528e37551eb49753fe982dcb";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-BiqNLYTQseymHgkZ3RLHOesxi6qaf4L0j8dgpgaG7LI=";
    };
  };
  wlx-overlay-s = {
    pname = "wlx-overlay-s";
    version = "afb71b1985d8598db23ec415cfb4e5ac67730084";
    src = fetchgit {
      url = "https://github.com/galister/wlx-overlay-s.git";
      rev = "afb71b1985d8598db23ec415cfb4e5ac67730084";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-+tbvKZ4GjHeCH2WPKXYS4kQGiDLeKFwBhClV9XUjX24=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./wlx-overlay-s-afb71b1985d8598db23ec415cfb4e5ac67730084/Cargo.lock;
      outputHashes = {
        "ovr_overlay-0.0.0" = "sha256-NHzESKsghqI98pkQxEmcNkQ9lTfBsqR9/25msbryi6E=";
        "openxr-0.19.0" = "sha256-mljVBbQTq/k7zd/WcE1Sd3gibaJiZ+t7td964clWHd8=";
        "libspa-0.8.0" = "sha256-Gub2F/Gwia8DjFqUsM8e4Yr2ff92AwrWrszsws3X3sM=";
        "wlx-capture-0.5.3" = "sha256-1R5R9a9MSCWZ+S8GXu2oMBodoy9CCmCfAwH1eXBPqno=";
        "wayvr_ipc-0.1.0" = "sha256-ieQaY08Ogl/F3t/p825LBp1lAO3SWH1F8206IPXEgTc=";
      };
    };
    date = "2025-07-26";
  };
  xrizer = {
    pname = "xrizer";
    version = "0997ff68d0e43d6ee3215f3ecb294a38e0b05485";
    src = fetchgit {
      url = "https://github.com/Supreeeme/xrizer.git";
      rev = "0997ff68d0e43d6ee3215f3ecb294a38e0b05485";
      fetchSubmodules = false;
      deepClone = false;
      leaveDotGit = false;
      sparseCheckout = [ ];
      sha256 = "sha256-ecvcJqcw+W9WPfo9WG+7lSBFgIDvaXx9VvSxtAsa/Kg=";
    };
    cargoLock."Cargo.lock" = {
      lockFile = ./xrizer-0997ff68d0e43d6ee3215f3ecb294a38e0b05485/Cargo.lock;
      outputHashes = {
        "openxr-0.19.0" = "sha256-mljVBbQTq/k7zd/WcE1Sd3gibaJiZ+t7td964clWHd8=";
      };
    };
    date = "2025-07-28";
  };
}
