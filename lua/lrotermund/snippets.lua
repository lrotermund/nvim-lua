
function InteractiveInsertFunctionSkeleton()
    local language = vim.fn.input('Choose a programming language (php/go): ')
    local function_name = vim.fn.input('Choose a name for the function: ')
    local function_code = ''

    if language == 'php' then
        function_code = string.format("private function %s(): void\n{\n\n}", function_name)
    elseif language == 'go' then
        function_code = string.format("func %s() {\n\t\n}", function_name)
    else
        print('Unsupported programming language')
        return
    end

    vim.api.nvim_feedkeys('i' .. function_code, 'n', true)
end

function InteractiveInsertClassSkeleton()
    local language = vim.fn.input('Choose a programming language (php/go): ')
    local class_name = ''
    local class_code = ''

    if language == 'php' then
        class_name = vim.fn.input('Choose a name for the class: ')
        local namesspace_name = vim.fn.input('Choose a namespace: ')

        class_code = string.format(
            "<?php\n\ndeclare(strict_types=1);\n\nnamespace %s;\n\nfinal readonly class %s\n{\npublic function __construct()\n{\n}\n}",
            namesspace_name,
            class_name
        )
    elseif language == 'go' then
        class_name = vim.fn.input('Choose a name for the struct: ')
        class_code = string.format("type %s struct {\n\t\n}", class_name)
    else
        print('Unsupported programming language')
        return
    end

    vim.api.nvim_feedkeys('i' .. class_code, 'n', true)
end

function GotoPHPTest()
    -- /home/lukas/Repositories/foobar/src/Service/foo.php
    -- --> /home/lukas/Repositories/foobar/tests/Service/fooTest.php
    local path = vim.api.nvim_buf_get_name(0)

    if not path:match("/src/") or not path:match("%.php$") then
        print('no PHP class')

        return false
    end

    local testPath = string.gsub(
        string.gsub(path, '/src/', '/tests/'),
        '.php',
        'Test.php'
    )
    local f = io.open(testPath, 'r')

    if f then
        f:close()
        vim.cmd("edit " .. testPath)
    else
        vim.cmd("enew")
        vim.cmd("file " .. testPath)
    end
end

function GotoPHPClass()
    -- /home/lukas/Repositories/foobar/tests/Service/fooTest.php
    -- --> /home/lukas/Repositories/foobar/src/Service/foo.php
    local path = vim.api.nvim_buf_get_name(0)

    if not path:match("/tests/") or not path:match("%Test.php$") then
        print('no PHP test')

        return false
    end

    local classPath = string.gsub(
        string.gsub(path, '/tests/', '/src/'),
        'Test.php',
        '.php'
    )
    local f = io.open(classPath, 'r')

    if f then
        f:close()
        vim.cmd("edit " .. classPath)
    else
        vim.cmd("enew")
        vim.cmd("file " .. classPath)
    end
end

vim.cmd([[command! -nargs=0 Ifs lua InteractiveInsertFunctionSkeleton()]])
vim.cmd([[command! -nargs=0 Ics lua InteractiveInsertClassSkeleton()]])
vim.cmd([[command! -nargs=0 Ptest lua GotoPHPTest()]])
vim.cmd([[command! -nargs=0 Pclass lua GotoPHPClass()]])
