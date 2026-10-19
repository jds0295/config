return {
  'nvim-java/nvim-java',
  config = function()
    require('java').setup()
    vim.lsp.enable('jdtls')
  end,
}

-- return {
-- 	"mfussenegger/nvim-jdtls",
-- 	ft = { "java" }, -- lazy-load only for Java files
--
-- 	config = function()
-- 		local jdtls = require("jdtls")
--
-- 		local root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
--
-- 		if not root_dir then
-- 			return
-- 		end
--
-- 		local home = os.getenv("HOME")
-- 		local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
--
-- 		-- Mason-managed jdtls paths
-- 		local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
-- 		local config = jdtls_path .. "/config_mac" -- change to config_linux / config_win if needed
-- 		local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
--
-- 		local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
-- 		local jdtls_config = {
-- 			cmd = {
-- 				"java",
-- 				"-Declipse.application=org.eclipse.jdt.ls.core.id1",
-- 				"-Dosgi.bundles.defaultStartLevel=4",
-- 				"-Declipse.product=org.eclipse.jdt.ls.core.product",
-- 				"-Dlog.protocol=true",
-- 				"-Dlog.level=ALL",
-- 				"-Xms1g",
-- 				"--add-modules=ALL-SYSTEM",
-- 				"--add-opens",
-- 				"java.base/java.util=ALL-UNNAMED",
-- 				"--add-opens",
-- 				"java.base/java.lang=ALL-UNNAMED",
-- 				"-jar",
-- 				launcher,
-- 				"-configuration",
-- 				config,
-- 				"-data",
-- 				workspace_dir,
-- 			},
-- 			root_dir = root_dir,
-- 			capabilities = capabilities,
-- 		}
--
-- 		jdtls.start_or_attach(jdtls_config)
-- 	end,
-- }
