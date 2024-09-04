{ pkgs, ... }: {
  channel = "stable-23.11";
  services.mysql.enable = true; 
  packages = [
    pkgs.python3
    pkgs.mysql
  ];
  env = {};
  idx = {
    extensions = [
      "ms-python.debugpy"
      "ms-python.python"
      "samuelcolvin.jinjahtml"
      "cweijan.vscode-mysql-client2"
      "Tobermory.es6-string-html"
      
    ];
    # Enable previews
    previews = {
      enable = true;
      previews = {
        web = {
          command = [ "./devserver.sh" ];
          env = { PORT = "$PORT"; };
          manager = "web";
        };
      };
    };
    workspace = {
      onCreate = {
        install =
          "python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt";
      };
      onStart = {
      };
    };
  };
}