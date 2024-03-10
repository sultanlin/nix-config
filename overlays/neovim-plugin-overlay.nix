{inputs}: final: prev: let
  mkNvimPlugin = src: pname:
    prev.pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
    };
in {
  neotest-java = mkNvimPlugin inputs.neotest-java "neotest-java";
  sentiment-nvim = mkNvimPlugin inputs.sentiment-nvim "sentiment.nvim";
}
