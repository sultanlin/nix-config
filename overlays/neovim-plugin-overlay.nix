{
  # neotest-java,
  sentiment-nvim,
  inputs,
  ...
}: (final: prev: {
  vimplugins = let
    mkNvimPlugin = src: pname:
      prev.vimUtils.buildVimPlugin {
        name = pname;
        inherit src;
      };
  in {
    vimPlugins =
      prev.vimPlugins
      // {
        neotest-java = mkNvimPlugin inputs.neotest-java "neotest-java";
        sentiment-nvim = mkNvimPlugin inputs.sentiment-nvim "sentiment.nvim";
        # sentiment-nvim = mkNvimPlugin sentiment-nvim "sentiment.nvim";
      };
  };
})
# {sentiment-nvim, ...}: (final: prev: {
#   vimPlugins =
#     prev.vimPlugins
#     // {
#       own-sentiment-nvim = prev.vimUtils.buildVimPlugin {
#         name = "sentiment.nvim";
#         src = sentiment-nvim;
#       };
#     };
# })
# } @ inputs: (final: prev:
#   vimPlugins =
#     prev.vimPlugins
#     // { let
#     mkNvimPlugin = src: pname:
#     in
#       own-sentiment-nvim = prev.vimUtils.buildVimPlugin {
#         name = "sentiment.nvim";
#         src = sentiment-nvim;
#       };
#     };
#   mkNvimPlugin = src: pname:
#     prev.pkgs.vimUtils.buildVimPlugin {
#       inherit pname src;
#     };
# # in {
# #   neotest-java = mkNvimPlugin inputs.neotest-java "neotest-java";
# #   sentiment-nvim = mkNvimPlugin inputs.sentiment-nvim "sentiment.nvim";
# # }
# )
