{
  description = "My (Jalil's) devShell template";

  outputs = { self }: {
    templates = {
      default = self.templates.devshell;
      devshell = {
        path = ./devshell;
        description = "A starting point for your devshell";
      };
    };
  };
}
