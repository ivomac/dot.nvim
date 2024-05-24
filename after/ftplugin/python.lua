
vim.opt_local.makeprg = 'pylint --reports=n --msg-template="{path}:{line}: {msg_id}:{obj} {msg}" %:p'
vim.opt_local.errorformat = "%f:%l: %m"

