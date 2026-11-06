include $(TOPDIR)/rules.mk

PKG_NAME:=voucher-wifi
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/voucher-wifi
@@SECTION:=net
@@CATEGORY:=Network
@@TITLE:=Sistem voucher wifi (openNDS)
@@DEPENDS:=+opennds
@@PKGARCH:=all
endef

define Package/voucher-wifi/description
Portal voucher untuk wifi tamu berbasis openNDS theme_voucher.
endef

define Package/voucher-wifi/conffiles
/etc/voucher-wifi/vouchers.txt
endef

define Build/Prepare
@@mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/voucher-wifi/install
@@$(INSTALL_DIR) $(1)/usr/bin $(1)/etc/init.d $(1)/usr/lib/opennds $(1)/etc/voucher-wifi
@@$(INSTALL_BIN) ./files/voucher $(1)/usr/bin/voucher
@@$(INSTALL_BIN) ./files/voucher-setup $(1)/usr/bin/voucher-setup
@@$(INSTALL_BIN) ./files/voucher-wifi.init $(1)/etc/init.d/voucher-wifi
@@$(INSTALL_BIN) ./files/theme_voucher.sh $(1)/usr/lib/opennds/theme_voucher.sh
@@$(INSTALL_DATA) ./files/vouchers.txt $(1)/etc/voucher-wifi/vouchers.txt
endef

define Package/voucher-wifi/postinst
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || /etc/init.d/voucher-wifi enable
exit 0
endef

$(eval $(call BuildPackage,voucher-wifi))
