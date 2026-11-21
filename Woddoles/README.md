# WODDOLES OS
SO baseado em Debian 12 + XFCE, otimizado para Core i7-3117U / 4 GB RAM. Veja `docs/ARCHITECTURE.md`.

## Gerar a ISO (Debian 12 ou Ubuntu, com internet, ~15 GB livres)
    ./build.sh
A ISO aparece em `build/`. Teste primeiro em VM (4 GB de RAM), depois grave em pendrive
(`sudo dd if=build/*.iso of=/dev/sdX bs=4M status=progress conv=fsync`, conferindo o /dev/sdX!).

## Status
1. Arquitetura: feita
2. Base do SO: escrita, NÃO testada
3-12: pendentes (painel estilo Windows, Settings unificado, medição de RAM, VM, hardware real)
