# Verse Calculus Experiments in Coq

This repository contains various experiments in formalization and verification of the [Verse Calculus](https://simon.peytonjones.org/assets/pdfs/verse-conf.pdf) in [Coq](https://coq.inria.fr/). It assumes a recent installation of the [Coq Platform](https://github.com/coq/platform) including at least Coq 8.15.1. It also uses [git submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to include libraries that are not (yet) published as OPAM packages, so if you cloned this repository without using `--recurse-submodules`, you'll need to `git submodule update --init`, like everyone else who has ever cloned a git repository with submodules.

## Experiments

* Use [The Zoo of Lambda-Calculus Reduction Strategies, And Coq](https://drops.dagstuhl.de/opus/volltexte/2022/16716/) to experiment with reduction strategies for the Verse Calculus. My suspicion is that the Verse Calculus uses the "LOW" strategy Biernacka et al. discovered (!), and I'd like to prove it (or refute it), and, if proven, prove confluence for the calculus, which the paper leaves as an open problem.
