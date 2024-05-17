local config = {
    -- Please start with minimal config possible.
    -- Just openai_api_key if you don't have OPENAI_API_KEY env set up.
    -- Defaults change over time to improve things, options might get deprecated.
    -- It's better to change only things where the default doesn't fit your needs.

    -- required openai api key (string or table with command and arguments)
    -- openai_api_key = { "cat", "path_to/openai_api_key" },
    -- openai_api_key = { "bw", "get", "password", "OPENAI_API_KEY" },
    -- openai_api_key: "sk-...",
    -- openai_api_key = os.getenv("env_name.."),
    openai_api_key = os.getenv("OPENAI_API_KEY"),
    -- api endpoint (you can change this to azure endpoint)
    openai_api_endpoint = "https://api.openai.com/v1/chat/completions",
    -- openai_api_endpoint = "https://$URL.openai.azure.com/openai/deployments/{{model}}/chat/completions?api-version=2023-03-15-preview",
    -- prefix for all commands
    cmd_prefix = "Gp",
    -- optional curl parameters (for proxy, etc.)
    -- curl_params = { "--proxy", "http://X.X.X.X:XXXX" }
    curl_params = {},

    -- directory for persisting state dynamically changed by user (like model or persona)
    state_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/persisted",

    -- default command agents (model + persona)
    -- name, model and system_prompt are mandatory fields
    -- to use agent for chat set chat = true, for command set command = true
    -- to remove some default agent completely set it just with the name like:
    -- agents = {  { name = "ChatGPT4" }, ... },
    agents = {

        {
            name = "ChatGPT4-turbo",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4-turbo", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
                .. "The user provided the additional info about how they would like you to respond:\n\n"
                .. "- If you're unsure don't guess and say you don't know instead.\n"
                .. "- Ask question if you need clarification to provide better answer.\n"
                .. "- Think deeply and carefully from first principles step by step.\n"
                .. "- Zoom out first to see the big picture and then zoom in to details.\n"
                .. "- Use Socratic method to improve your thinking and coding skills.\n"
                .. "- Don't elide any code from your output if the answer requires coding.\n"
                .. "- Take a deep breath; You've got this!\n",
        },

        {
            name = "ChatGPT4",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
                .. "The user provided the additional info about how they would like you to respond:\n\n"
                .. "- If you're unsure don't guess and say you don't know instead.\n"
                .. "- Ask question if you need clarification to provide better answer.\n"
                .. "- Think deeply and carefully from first principles step by step.\n"
                .. "- Zoom out first to see the big picture and then zoom in to details.\n"
                .. "- Use Socratic method to improve your thinking and coding skills.\n"
                .. "- Don't elide any code from your output if the answer requires coding.\n"
                .. "- Take a deep breath; You've got this!\n",
        },
        {
            name = "ChatGPT3-5",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-3.5-turbo-1106", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
                .. "The user provided the additional info about how they would like you to respond:\n\n"
                .. "- If you're unsure don't guess and say you don't know instead.\n"
                .. "- Ask question if you need clarification to provide better answer.\n"
                .. "- Think deeply and carefully from first principles step by step.\n"
                .. "- Zoom out first to see the big picture and then zoom in to details.\n"
                .. "- Use Socratic method to improve your thinking and coding skills.\n"
                .. "- Don't elide any code from your output if the answer requires coding.\n"
                .. "- Take a deep breath; You've got this!\n",
        },
        {
            name = "CodeGPT4",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor.\n\n"
                .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
                .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
        {
            name = "CodeGPT3-5",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-3.5-turbo-1106", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor.\n\n"
                .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
                .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
    },

    -- directory for storing chat files
    chat_dir = vim.fn.stdpath("data"):gsub("/$", "") .. "/gp/chats",
    -- chat user prompt prefix
    chat_user_prefix = "## user",
    -- chat assistant prompt prefix (static string or a table {static, template})
    -- first string has to be static, second string can contain template {{agent}}
    -- just a static string is legacy and the [{{agent}}] element is added automatically
    -- if you really want just a static string, make it a table with one element { "🤖:" }
    chat_assistant_prefix = { "## llm", "[{{agent}}]" },
    -- chat topic generation prompt
    chat_topic_gen_prompt = "Summarize the topic of our conversation above"
        .. " in two or three words. Respond only with those words.",
    -- chat topic model (string with model name or table with model name and parameters)
    chat_topic_gen_model = "gpt-3.5-turbo-16k",
    -- explicitly confirm deletion of a chat file
    chat_confirm_delete = true,
    -- conceal model parameters in chat
    chat_conceal_model_params = true,
    -- local shortcuts bound to the chat buffer
    -- (be careful to choose something which will work across specified modes)
    chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
    chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
    chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
    chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>c" },
    -- default search term when using :GpChatFinder
    chat_finder_pattern = "topic ",
    -- if true, finished ChatResponder won't move the cursor to the end of the buffer
    chat_free_cursor = false,

    -- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
    toggle_target = "vsplit",

    -- styling for chatfinder
    -- border can be "single", "double", "rounded", "solid", "shadow", "none"
    style_chat_finder_border = "single",
    -- margins are number of characters or lines
    style_chat_finder_margin_bottom = 8,
    style_chat_finder_margin_left = 1,
    style_chat_finder_margin_right = 2,
    style_chat_finder_margin_top = 2,
    -- how wide should the preview be, number between 0.0 and 1.0
    style_chat_finder_preview_ratio = 0.5,

    -- styling for popup
    -- border can be "single", "double", "rounded", "solid", "shadow", "none"
    style_popup_border = "single",
    -- margins are number of characters or lines
    style_popup_margin_bottom = 8,
    style_popup_margin_left = 1,
    style_popup_margin_right = 2,
    style_popup_margin_top = 2,
    style_popup_max_width = 160,

    -- command config and templates bellow are used by commands like GpRewrite, GpEnew, etc.
    -- command prompt prefix for asking user for input (supports {{agent}} template variable)
    command_prompt_prefix_template = "🤖 {{agent}} ~ ",
    -- auto select command response (easier chaining of commands)
    -- if false it also frees up the buffer cursor for further editing elsewhere
    command_auto_select_response = true,

    -- templates
    template_selection = "I have the following from {{filename}}:"
        .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}",
    template_rewrite = "I have the following from {{filename}}:"
        .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
        .. "\n\nRespond exclusively with the snippet that should replace the selection above.",
    template_append = "I have the following from {{filename}}:"
        .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
        .. "\n\nRespond exclusively with the snippet that should be appended after the selection above.",
    template_prepend = "I have the following from {{filename}}:"
        .. "\n\n```{{filetype}}\n{{selection}}\n```\n\n{{command}}"
        .. "\n\nRespond exclusively with the snippet that should be prepended before the selection above.",
    template_command = "{{command}}",

    -- https://platform.openai.com/docs/guides/speech-to-text/quickstart
    -- Whisper costs $0.006 / minute (rounded to the nearest second)
    -- by eliminating silence and speeding up the tempo of the recording
    -- we can reduce the cost by 50% or more and get the results faster
    -- directory for storing whisper files
    whisper_dir = (os.getenv("TMPDIR") or os.getenv("TEMP") or "/tmp") .. "/gp_whisper",
    -- multiplier of RMS level dB for threshold used by sox to detect silence vs speech
    -- decibels are negative, the recording is normalized to -3dB =>
    -- increase this number to pick up more (weaker) sounds as possible speech
    -- decrease this number to pick up only louder sounds as possible speech
    -- you can disable silence trimming by setting this a very high number (like 1000.0)
    whisper_silence = "1.75",
    -- whisper max recording time (mm:ss)
    -- whisper_max_time = "05:00",
    -- whisper tempo (1.0 is normal speed)
    whisper_tempo = "1.75",
    -- The language of the input audio, in ISO-639-1 format.
    whisper_language = "en",

    -- image generation settings
    -- image prompt prefix for asking user for input (supports {{agent}} template variable)
    image_prompt_prefix_template = "🖌️ {{agent}} ~ ",
    -- image prompt prefix for asking location to save the image
    image_prompt_save = "🖌️💾 ~ ",
    -- default folder for saving images
    image_dir = (os.getenv("TMPDIR") or os.getenv("TEMP") or "/tmp") .. "/gp_images",
    -- default image agents (model + settings)
    -- to remove some default agent completely set it just with the name like:
    -- image_agents = {  { name = "DALL-E-3-1024x1792-vivid" }, ... },
    image_agents = {
        {
            name = "DALL-E-3-1024x1024-vivid",
            model = "dall-e-3",
            quality = "standard",
            style = "vivid",
            size = "1024x1024",
        },
        {
            name = "DALL-E-3-1792x1024-vivid",
            model = "dall-e-3",
            quality = "standard",
            style = "vivid",
            size = "1792x1024",
        },
        {
            name = "DALL-E-3-1024x1792-vivid",
            model = "dall-e-3",
            quality = "standard",
            style = "vivid",
            size = "1024x1792",
        },
        {
            name = "DALL-E-3-1024x1024-natural",
            model = "dall-e-3",
            quality = "standard",
            style = "natural",
            size = "1024x1024",
        },
        {
            name = "DALL-E-3-1792x1024-natural",
            model = "dall-e-3",
            quality = "standard",
            style = "natural",
            size = "1792x1024",
        },
        {
            name = "DALL-E-3-1024x1792-natural",
            model = "dall-e-3",
            quality = "standard",
            style = "natural",
            size = "1024x1792",
        },
        {
            name = "DALL-E-3-1024x1024-vivid-hd",
            model = "dall-e-3",
            quality = "hd",
            style = "vivid",
            size = "1024x1024",
        },
        {
            name = "DALL-E-3-1792x1024-vivid-hd",
            model = "dall-e-3",
            quality = "hd",
            style = "vivid",
            size = "1792x1024",
        },
        {
            name = "DALL-E-3-1024x1792-vivid-hd",
            model = "dall-e-3",
            quality = "hd",
            style = "vivid",
            size = "1024x1792",
        },
        {
            name = "DALL-E-3-1024x1024-natural-hd",
            model = "dall-e-3",
            quality = "hd",
            style = "natural",
            size = "1024x1024",
        },
        {
            name = "DALL-E-3-1792x1024-natural-hd",
            model = "dall-e-3",
            quality = "hd",
            style = "natural",
            size = "1792x1024",
        },
        {
            name = "DALL-E-3-1024x1792-natural-hd",
            model = "dall-e-3",
            quality = "hd",
            style = "natural",
            size = "1024x1792",
        },
    },

    -- example hook functions (see Extend functionality section in the README)
    hooks = {
        InspectPlugin = function(plugin, params)
            local bufnr = vim.api.nvim_create_buf(false, true)
            local copy = vim.deepcopy(plugin)
            local key = copy.config.openai_api_key
            copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
            local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
            local params_info = string.format("Command params:\n%s", vim.inspect(params))
            local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
            vim.api.nvim_win_set_buf(0, bufnr)
        end,

        -- GpImplement rewrites the provided selection/range based on comments in it
        Implement = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please rewrite this according to the contained instructions."
                .. "\n\nRespond exclusively with the snippet that should replace the selection above."

            local agent = gp.get_command_agent()
            gp.info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(
                params,
                gp.Target.rewrite,
                nil, -- command will run directly without any prompting for user input
                agent.model,
                template,
                agent.system_prompt
            )
        end,

        Doctring = function(gp, params)
            local template = "Having following from {{filename}}:\n\n"
                .. "```{{filetype}}\n{{selection}}\n```\n\n"
                .. "Please write a numpy style doctring for the function or class."
                .. "\n\nRespond exclusively with the doctring surronded by \"\"\""

            local agent = gp.get_command_agent()
            gp.info("Implementing selection with agent: " .. agent.name)

            gp.Prompt(
                params,
                gp.Target.append,
                nil, -- command will run directly without any prompting for user input
                agent.model,
                template,
                agent.system_prompt
            )
        end,

        -- your own functions can go here, see README for more examples like
        -- :GpExplain, :GpUnitTests.., :GpTranslator etc.

        -- -- example of making :%GpChatNew a dedicated command which
        -- -- opens new chat with the entire current buffer as a context
        -- BufferChatNew = function(gp, _)
        -- 	-- call GpChatNew command in range mode on whole buffer
        -- 	vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
        -- end,

        -- -- example of adding command which opens new chat dedicated for translation
        -- Translator = function(gp, params)
        -- 	local agent = gp.get_command_agent()
        -- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
        -- 	gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
        -- end,

        -- -- example of adding command which writes unit tests for the selected code
        -- UnitTests = function(gp, params)
        -- 	local template = "I have the following code from {{filename}}:\n\n"
        -- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
        -- 		.. "Please respond by writing table driven unit tests for the code above."
        -- 	local agent = gp.get_command_agent()
        -- 	gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
        -- end,

        -- -- example of adding command which explains the selected code
        -- Explain = function(gp, params)
        -- 	local template = "I have the following code from {{filename}}:\n\n"
        -- 		.. "```{{filetype}}\n{{selection}}\n```\n\n"
        -- 		.. "Please respond by explaining the code above."
        -- 	local agent = gp.get_chat_agent()
        -- 	gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
        -- end,
    },
}

require("gp").setup(config)


-- VISUAL mode mappings
-- s, x, v modes are handled the same way by which_key
require("which-key").register({
    -- ...
    ["<C-g>"] = {
        c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
        p = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
        t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },

        ["<C-x>"] = { ":<C-u>'<,'>GpChatNew split<cr>", "Visual Chat New split" },
        ["<C-v>"] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", "Visual Chat New vsplit" },
        ["<C-t>"] = { ":<C-u>'<,'>GpChatNew tabnew<cr>", "Visual Chat New tabnew" },

        r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
        a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append (after)" },
        b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend (before)" },
        i = { ":<C-u>'<,'>GpImplement<cr>", "Implement selection" },

        g = {
            name = "generate into new ..",
            p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
            e = { ":<C-u>'<,'>GpEnew<cr>", "Visual GpEnew" },
            n = { ":<C-u>'<,'>GpNew<cr>", "Visual GpNew" },
            v = { ":<C-u>'<,'>GpVnew<cr>", "Visual GpVnew" },
            t = { ":<C-u>'<,'>GpTabnew<cr>", "Visual GpTabnew" },
        },

        n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
        s = { "<cmd>GpStop<cr>", "GpStop" },
        x = { ":<C-u>'<,'>GpContext<cr>", "Visual GpContext" },

        w = {
            name = "Whisper",
            w = { ":<C-u>'<,'>GpWhisper<cr>", "Whisper" },
            r = { ":<C-u>'<,'>GpWhisperRewrite<cr>", "Whisper Rewrite" },
            a = { ":<C-u>'<,'>GpWhisperAppend<cr>", "Whisper Append (after)" },
            b = { ":<C-u>'<,'>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
            p = { ":<C-u>'<,'>GpWhisperPopup<cr>", "Whisper Popup" },
            e = { ":<C-u>'<,'>GpWhisperEnew<cr>", "Whisper Enew" },
            n = { ":<C-u>'<,'>GpWhisperNew<cr>", "Whisper New" },
            v = { ":<C-u>'<,'>GpWhisperVnew<cr>", "Whisper Vnew" },
            t = { ":<C-u>'<,'>GpWhisperTabnew<cr>", "Whisper Tabnew" },
        },
    },
    -- ...
}, {
    mode = "v", -- VISUAL mode
    prefix = "",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})

-- NORMAL mode mappings
require("which-key").register({
    -- ...
    ["<C-g>"] = {
        c = { "<cmd>GpChatNew<cr>", "New Chat" },
        t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
        f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

        ["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
        ["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
        ["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

        r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
        a = { "<cmd>GpAppend<cr>", "Append (after)" },
        b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

        g = {
            name = "generate into new ..",
            p = { "<cmd>GpPopup<cr>", "Popup" },
            e = { "<cmd>GpEnew<cr>", "GpEnew" },
            n = { "<cmd>GpNew<cr>", "GpNew" },
            v = { "<cmd>GpVnew<cr>", "GpVnew" },
            t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
        },

        n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
        s = { "<cmd>GpStop<cr>", "GpStop" },
        x = { "<cmd>GpContext<cr>", "Toggle GpContext" },

        w = {
            name = "Whisper",
            w = { "<cmd>GpWhisper<cr>", "Whisper" },
            r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
            a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
            b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
            p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
            e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
            n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
            v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
            t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
        },
    },
    -- ...
}, {
    mode = "n", -- NORMAL mode
    prefix = "",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})

-- INSERT mode mappings
require("which-key").register({
    -- ...
    ["<C-g>"] = {
        c = { "<cmd>GpChatNew<cr>", "New Chat" },
        t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
        f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

        ["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
        ["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
        ["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

        r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
        a = { "<cmd>GpAppend<cr>", "Append (after)" },
        b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

        g = {
            name = "generate into new ..",
            p = { "<cmd>GpPopup<cr>", "Popup" },
            e = { "<cmd>GpEnew<cr>", "GpEnew" },
            n = { "<cmd>GpNew<cr>", "GpNew" },
            v = { "<cmd>GpVnew<cr>", "GpVnew" },
            t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
        },

        x = { "<cmd>GpContext<cr>", "Toggle GpContext" },
        s = { "<cmd>GpStop<cr>", "GpStop" },
        n = { "<cmd>GpNextAgent<cr>", "Next Agent" },

        w = {
            name = "Whisper",
            w = { "<cmd>GpWhisper<cr>", "Whisper" },
            r = { "<cmd>GpWhisperRewrite<cr>", "Whisper Inline Rewrite" },
            a = { "<cmd>GpWhisperAppend<cr>", "Whisper Append (after)" },
            b = { "<cmd>GpWhisperPrepend<cr>", "Whisper Prepend (before)" },
            p = { "<cmd>GpWhisperPopup<cr>", "Whisper Popup" },
            e = { "<cmd>GpWhisperEnew<cr>", "Whisper Enew" },
            n = { "<cmd>GpWhisperNew<cr>", "Whisper New" },
            v = { "<cmd>GpWhisperVnew<cr>", "Whisper Vnew" },
            t = { "<cmd>GpWhisperTabnew<cr>", "Whisper Tabnew" },
        },
    },
    -- ...
}, {
    mode = "i", -- INSERT mode
    prefix = "",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
})
