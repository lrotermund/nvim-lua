function Is_php_or_go_file()
    local path = vim.api.nvim_buf_get_name(0)
    if not path:match("%.go") or not path:match("%.php$") then
        print('no Go or PHP file')

        return false
    end

    return true
end

function Interactive_insert_function_skeleton()
    if not Is_php_or_go_file then
        return false
    end

    local path = vim.api.nvim_buf_get_name(0)
    local function_name = vim.fn.input('Choose a name for the function: ')
    local function_code = ''

    if path:match("%.php") then
        function_code = string.format("private function %s(): void\n{\n\n}", function_name)
    else
        function_code = string.format("func %s() {\n\t\n}", function_name)
    end

    vim.api.nvim_feedkeys('i' .. function_code, 'n', true)
end

function Interactive_insert_class_skeleton()
    if not Is_php_or_go_file then
        return false
    end

    local path = vim.api.nvim_buf_get_name(0)
    local class_name = ''
    local class_code = ''

    if path:match("%.php") then
        class_name = vim.fn.input('Choose a name for the class: ')
        local namesspace_name = vim.fn.input('Choose a namespace: ')

        class_code = string.format(
            "<?php\n\ndeclare(strict_types=1);\n\nnamespace %s;\n\nfinal readonly class %s\n{\npublic function __construct()\n{\n}\n}",
            namesspace_name,
            class_name
        )
    else
        class_name = vim.fn.input('Choose a name for the struct: ')
        class_code = string.format("type %s struct {\n\t\n}", class_name)
    end

    vim.api.nvim_feedkeys('i' .. class_code, 'n', true)
end

function Goto_php_test()
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

function Goto_php_mockery_test()
    -- /home/lukas/Repositories/foobar/src/Service/foo.php
    -- --> /home/lukas/Repositories/foobar/tests/Service/fooMockeryTest.php
    local path = vim.api.nvim_buf_get_name(0)

    if not path:match("/src/") or not path:match("%.php$") then
        print('no PHP class')

        return false
    end

    local testPath = string.gsub(
        string.gsub(path, '/src/', '/tests/'),
        '.php',
        'MockeryTest.php'
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

function Goto_php_class()
    -- /home/lukas/Repositories/foobar/tests/Service/fooTest.php
    -- or /home/lukas/Repositories/foobar/tests/Service/fooMockeryTest.php
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
        local mockeryClassPath = string.gsub(
            string.gsub(path, '/tests/', '/src/'),
            'MockeryTest.php',
            '.php'
        )
        local mf = io.open(mockeryClassPath, 'r')

        if mf then
            mf:close()
            vim.cmd("edit " .. mockeryClassPath)
        else
            vim.cmd("enew")
            vim.cmd("file " .. classPath)
        end
    end
end

vim.cmd([[command! -nargs=0 Ifs lua Interactive_insert_function_skeleton()]])
vim.cmd([[command! -nargs=0 Ics lua Interactive_insert_class_skeleton()]])
vim.cmd([[command! -nargs=0 Ptest lua Goto_php_test()]])
vim.cmd([[command! -nargs=0 Pmtest lua Goto_php_mockery_test()]])
vim.cmd([[command! -nargs=0 Pclass lua Goto_php_class()]])
