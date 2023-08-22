
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

vim.cmd([[command! -nargs=0 Ifs lua InteractiveInsertFunctionSkeleton()]])
vim.cmd([[command! -nargs=0 Ics lua InteractiveInsertClassSkeleton()]])
