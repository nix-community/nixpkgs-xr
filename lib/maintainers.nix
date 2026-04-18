# SPDX-FileCopyrightText: 2025 Sefa Eyeoglu <contact@scrumplex.net>
#
# SPDX-License-Identifier: MIT
/*
  List of active NixOS maintainers.
   ```nix
   handle = {
     # Required
     name = "Your name";
     github = "GithubUsername";
     githubId = your-github-id;

     # Optional
     email = "address@example.org";
     matrix = "@user:example.org";
     keys = [{
       fingerprint = "AAAA BBBB CCCC DDDD EEEE  FFFF 0000 1111 2222 3333";
     }];
   };
   ```
*/
{
  coolGi = {
    email = "me@coolgi.dev";
    github = "coolGi69";
    githubId = 57488297;
    name = "coolGi";
    matrix = "@me:coolgi.dev";
    keys = [
      { fingerprint = "1E3E C960 F2C0 9128 5398  A4A9 28B0 7544 198A DB06"; }
    ];
  };
  Red_M = {
    name = "Red_M";
    github = "Red-M";
    githubId = 1468433;
  };
}
