# WODDOLES OS — Arquitetura (Etapa 1)

## Decisão central
Distribuição própria **derivada do Debian 12 "bookworm" (amd64)**, montada com **live-build**.
Não escrevemos um kernel do zero nem simulamos um SO em HTML/JS: usamos componentes reais, testados e com
patches de segurança, e personalizamos o que o usuário vê e o que roda em segundo plano.

## Por que Debian + live-build
- Gera ISO híbrida (pendrive) com BIOS Legacy (syslinux) e UEFI (GRUB EFI) no mesmo arquivo.
- Atualizações de segurança e gerenciador de pacotes (apt) prontos = "suporte a atualizações" real.
- Firmware de Wi-Fi/Ethernet disponível (`non-free-firmware`).
- Instalador gráfico **Calamares** (HD/SSD, ext4, UEFI e BIOS).

## Kernel
Kernel **stock do Debian** (`linux-image-amd64`), não recompilado. Motivo: já inclui i915 (Intel HD 4000),
USB, ext4, zram, AppArmor, Wi-Fi/Bluetooth. Recompilar aumenta o risco de instabilidade e perda de
atualizações de segurança, e o ganho de RAM é pequeno. Só vale revisitar na Etapa 9 com medições.

## Interface
- **XFCE 4** + **xfwm4 com compositor desligado** (menos RAM/CPU no HD 4000).
- Painel inferior + **Whisker Menu** = barra de tarefas e menu Iniciar no estilo Windows (painel: Etapa 5).
- **LightDM + lightdm-gtk-greeter** com tela de login própria.
- Driver gráfico: `modesetting` do Xorg (sem `xserver-xorg-video-intel`).

## Mapeamento dos aplicativos
| WODDOLES | Base |
|---|---|
| Explorer | Thunar + gvfs + udisks2 (USB) |
| Settings | xfce4-settings + nm-connection-editor + pavucontrol + blueman |
| Browser | Firefox ESR (o item mais pesado; alternativa avaliada na Etapa 9) |
| Notepad | Mousepad |
| Calculator | galculator |
| Task Manager | xfce4-taskmanager |
| Terminal | xfce4-terminal |
| Image Viewer | Ristretto |
| Media Player | Parole |

## Memória e segurança
- zRAM (zstd, 50%) via zram-tools; sysctl ajustado para swap em zram.
- Serviços mínimos: ModemManager e avahi mascarados; sem CUPS.
- Segurança mantida: contas/sudo/polkit, **ufw ativo**, **AppArmor**, unattended-upgrades, Secure Boot via shim assinado do Debian.

## Status (honesto)
Nada foi compilado nem testado ainda: este ambiente não tem rede nem VM. A primeira execução do build
em uma máquina Debian provavelmente exigirá ajustes.
