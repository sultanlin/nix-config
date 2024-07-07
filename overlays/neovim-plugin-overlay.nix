{
  # neotest-java,
  # sentiment-nvim,
  ...
} @ inputs: (final: prev: {
  vimPlugins = let
    mkNvimPlugin = src: name:
      prev.vimUtils.buildVimPlugin {
        inherit name src;
      };
  in
    # vimPlugins =
    prev.vimPlugins
    // {
      neotest-java = mkNvimPlugin inputs.neotest-java "neotest-java";
      sentiment-nvim = mkNvimPlugin inputs.sentiment-nvim "sentiment.nvim";
      grapple-nvim = mkNvimPlugin inputs.grapple-nvim "grapple.nvim";
      # sentiment-nvim = mkNvimPlugin sentiment-nvim "sentiment.nvim";
      neotest-vim-test = mkNvimPlugin inputs.neotest-vim-test "neotest-vim-test";
      spring-boot-java = mkNvimPlugin inputs.spring-boot-java "spring-boot-java";
    };
})
