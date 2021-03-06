clean:
	flutter clean
	flutter pub get

upgrade:
	flutter packages upgrade

icon:
	flutter pub get
	flutter pub run flutter_launcher_icons:main

generate-keystore:
	keytool -genkey -v -keystore ~/jibekey.jks -keyalg RSA -keysize 2048 -validity 10000 -alias jibekey

list-keystore:
	keytool -list -v -alias jibekey -keystore ~/jibekey.jks

bundle:
	flutter build appbundle

archive:
	flutter build ipa

apk:
	flutter build apk --split-per-abi

build-ios:
	flutter build ios

install-android: clean apk
	flutter install

install-ios: clean build-ios
	flutter install