-- local gitlab_pat = function()
-- 	local f = assert(io.open(os.getenv("HOME") .. "/gitlab/pat.txt", "rb"))
-- 	local content = f:read("*a")
-- 	f:close()
-- 
-- 	return string.gsub(content, "%s+", "")
-- end
-- 
-- vim.g.fugitive_gitlab_domains = {
--     ["ssh://gitlab.tasko.de"] = "https://gitlab.tasko.de"
-- }
-- 
-- vim.g.gitlab_api_keys = {
--     ["gitlab.tasko.de"] = gitlab_pat()
-- }
