# Menggunakan image Kali Linux terbaru
FROM kalilinux/kali-rolling

# Menambahkan repository Kali
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list

# Update paket dan instalasi paket yang dibutuhkan
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    nano \
    neofetch \
    jq \
    kali-desktop-kde \
    kali-linux-core \
    dbus \
    x11-apps \
    x11vnc \
    xrdp \
    git \
    sudo \
    curl \
    # Instalasi 20 tool teratas
    aircrack-ng \
    burpsuite \
    metasploit-framework \
    nmap \
    nikto \
    sqlmap \
    gobuster \
    hydra \
    john \
    wireshark \
    medusa \
    hashcat \
    dirb \
    dnsenum \
    tcpdump \
    lsof \
    tcpflow \
    xclip \
    # Instalasi forensic tools
    sleuthkit \
    autopsy \
    && apt-get clean

# Menambahkan user "Bagus" dengan password dan izin sudo
RUN useradd -m -s /bin/bash -G sudo Bagus && \
    echo "Bagus:Kopisusu12#" | chpasswd && \
    echo "Bagus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Mengubah konfigurasi XRDP agar berjalan di port 3390
RUN sed -i 's/port=3389/port=3390/g' /etc/xrdp/xrdp.ini

# Instalasi Localtonet
RUN curl -Lo localtonet.zip https://localtonet.com/downloads/localtonet-linux.zip && \
    unzip localtonet.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/localtonet && \
    rm localtonet.zip

# Konfigurasi XRDP untuk menggunakan sesi KDE
RUN echo "startplasma-x11" > /root/.xsession && \
    echo "startplasma-x11" > /home/Bagus/.xsession && \
    chmod +x /root/.xsession && chmod +x /home/Bagus/.xsession

# Salin start-localtonet.sh untuk menjalankan localtonet saat kontainer dimulai
COPY start-localtonet.sh /start-localtonet.sh
RUN chmod +x /start-localtonet.sh

# Expose port yang dibutuhkan untuk XRDP
EXPOSE 3390

# Set lingkungan user ke Bagus
ENV USER=Bagus

# Gunakan start-localtonet.sh sebagai entrypoint untuk menjaga agar sesi tetap ada saat kontainer dijalankan
CMD ["/start-localtonet.sh"]
