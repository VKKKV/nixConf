/**
 * home/common/core/packages.nix
 * General user-level packages that don't need specific configuration.
 */
{pkgs, ...}: {
  home.packages = with pkgs; [
    # Java Runtime
    zulu17

    # Development Tools & Editors
    (ripgrep.override {withPCRE2 = true;})
    alejandra
    jetbrains.idea-community-bin
    nil
    nixd
    nixfmt
    gcc
    gnumake
    nodejs_24
    tokei
    cloc

    # Container & Virtualization Tools
    podman-compose
    dive
    lazydocker

    # Database Clients
    mycli
    pgcli
    mongosh
    sqlite

    # Network Diagnostics & Tools
    wireshark
    mitmproxy
    nmap
    tcpdump
    mtr
    iperf3
    doggo
    dnsutils
    ldns
    socat
    aria2
    curlie
    httpie

    # System Monitoring & Hardware Info
    nmon
    fastfetch
    nvitop
    procs
    duf
    dust
    gdu
    ncdu

    # Debugging & Tracing
    bpfmon
    bpftop
    bpftrace
    strace
    ltrace

    # File Management & CLI Utilities
    fd
    fzf
    tree
    rsync
    croc
    trashy

    # Text Processing
    jq
    yq-go
    jc
    gnused
    gawk
    gnugrep
    sad
    hyperfine
    calc

    # Multimedia & Graphics
    ffmpeg-full
    imagemagick
    graphviz
    imv
    viu
    foliate
    pavucontrol
    pwvucontrol
    playerctl
    pulsemixer
    libva-utils
    vdpauinfo
    vulkan-tools
    mesa-demos

    # Gaming & Compatibility
    heroic
    mangohud
    protonplus
    winetricks
    kicad

    # Web Browsers & Communication
    google-chrome
    firefox
    remmina
    freerdp
    moonlight-qt
    localsend

    # Version Control
    git-lfs
    git-trim
    gitleaks

    # Miscellaneous Utilities
    binsider
    sysbench
    sysstat
    systemctl-tui
    gping
    libargon2
  ];
}
