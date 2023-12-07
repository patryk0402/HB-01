echo '== Setting up Dpkg options ==' &&
  export DEBIAN_FRONTEND=noninteractive &&
  echo -e 'Dpkg::Options {\n  "--force-confnew";\n}' > ~/../usr/etc/apt/apt.conf.d/local &&
  echo '== Removing invalid repositories ==' &&
  pkg remove -y game-repo &&
  pkg remove -y science-repo &&
  echo '== Updating repositories and upgrading packages ==' &&
  pkg update -y &&
  pkg upgrade -y &&
  echo '== Installing python, openssl and nodejs ==' &&
  pkg install -y libicu &&
  pkg install -y python openssl-1.1 nodejs &&
  echo '== Removing added Dpkg options ==' &&
  rm ~/../usr/etc/apt/apt.conf.d/local &&
  echo '== Installing homebridge and homebridge-config-ui ==' &&
  npm install -g --unsafe-perm homebridge homebridge-config-ui-x &&
  echo '== Creating default config ==' &&
  mkdir -p ~/.homebridge &&
  echo -e '{\n	"bridge": {\n		"name": "Homebridge PD93",\n		"username": "6C:B7:49:47:43:AF",\n		"port": 51211,\n		"pin": "210-11-965",\n		"advertiser": "bonjour-hap"\n	},\n	"accessories": [],\n	"platforms": []\n}\n' > ~/.homebridge/config.json &&
  echo '== Adding homebridge commands ==' &&
  echo 'exec npx homebridge "$@" 2>&1 | tee ~/.homebridge/homebridge.log' > ~/../usr/bin/hb &&
  chmod +x ~/../usr/bin/hb &&
  echo -e '== Installation successful ==\nExecute hb command to start'
