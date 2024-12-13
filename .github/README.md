# Nixus

<div align="center">
  <img src="ss.png" alt="screenshot of my setup" width="600" />
</div>

## About

This repo contains my reorganized and rewritten NixOS configuration.
It might not be widely considered _correct_ or whatever, because I used some of my braincells to come up with this autistic design philosophy:

- as little inputs as possible, just straight up rawdogging nix
- wrap binaries instead of putting files in home dir
- do not copy from others
- try to avoid `with` keyword as much as possible

## Contents

- **NixOS hosts** - my twinkpad x1 and macbook air m1 (running asahi kernel)
- **NixOS modules** - including $HOME management, impermanence and some laptop specific things
- **Dev shell** - shell containing my entire terminal workflow, with fully configured neovim and stuff. 
- **Packages** - Mostly unmodified packages from nixpkgs, wrapped with my configs, themed via base16 attribute set
- **Theme** - which outputs my current base16 theme as an attrset 

# Why I don't use some of the popular NixOS modules?

## Home-manager

I don't like it. I prefer to wrap my binaries. Much better solution.

Everyone in nix community will tell you that hm is a mess.

I also use my own module [homix](https://github.com/sioodmy/homix) for stuff I couldnt't wrap with symlinkJoin, like gtk

## Flake-parts

I was able to fully replace it with a single lambda

## Impermanence

I found it needlessly overcomplicated and unreliable.

## Nix-colors

It's just a glorified attribute set

## 💛 Donate

If you would like to support me you can sponsor me via ko-fi

<a href="https://ko-fi.com/sioodmy"><img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Support me on kofi" /> </a>

... or if you prefer crypto

Ethereum/EVM compatible: `0x2fa1e5e90c011d08bba1f6dbdc317fd293311c0d`

[![Star History Chart](https://api.star-history.com/svg?repos=sioodmy/dotfiles&type=Date)](https://star-history.com/#sioodmy/dotfiles&Date)
