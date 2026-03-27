{self, ...}: {
  flake.homeModules.allTools = {...}: {
    imports = with self.homeModules; [java nodejs];
  };
}
