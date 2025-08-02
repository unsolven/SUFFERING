--[[
    ================================================================
    ==            SCRIPT DE EXEMPLO - LoUI HUB COMPLETO           ==
    ================================================================
    
    Este script demonstra todas as funcionalidades da biblioteca LoUI
    criando um Hub funcional com múltiplas abas e recursos práticos.
    
    Use-o como um template para seus próprios projetos!
    
]]

-- Carrega a biblioteca LoUI do seu repositório
local LoUILibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/unsolven/SUFFERING/refs/heads/main/LoUI.lua"))()

-- Variáveis locais para o jogador e personagem
local player = game:GetService("Players").LocalPlayer

--================================================================
-- 1. CONFIGURAÇÃO DA JANELA PRINCIPAL
--================================================================

-- Carrega a janela principal com um título e um ícone (opcional)
local window = LoUILibrary:Load("LoUI Hub de Exemplo")

-- Define a transparência inicial da UI para um efeito de vidro (0 = opaco, 1 = invisível)
window:SetTransparency(0.2)


--================================================================
-- 2. ABA "JOGADOR" - FUNÇÕES QUE AFETAM O USUÁRIO
--================================================================

local tabJogador = LoUILibrary.newTab("Jogador", "rbxassetid://13529337034")

tabJogador.newLabel("Funções do Personagem")

-- Slider para Velocidade de Caminhada (WalkSpeed)
tabJogador.newSlider("Velocidade", "Altera sua velocidade de caminhada.", 200, false, function(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = value
    end
end)

-- Slider para Força do Pulo (JumpPower)
tabJogador.newSlider("Força do Pulo", "Altera a altura do seu pulo.", 300, false, function(value)
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = value
    end
end)

-- Toggle para Noclip (atravessar paredes)
local noclipEnabled = false
local noclipConnection = nil
tabJogador.newToggle("Noclip", "Permite voar e atravessar objetos.", false, function(state)
    noclipEnabled = state
    if noclipEnabled then
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                for _, part in ipairs(player.Character:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
            -- A colisão será reativada pelo Roblox automaticamente
        end
    end
end)

tabJogador.newButton("Redefinir Status", "Volta a velocidade e pulo para o padrão.", function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        player.Character.Humanoid.JumpPower = 50
        print("Status do jogador redefinidos!")
    end
end)


--================================================================
-- 3. ABA "MUNDO" - FUNÇÕES QUE AFETAM O AMBIENTE
--================================================================

local tabMundo = LoUILibrary.newTab("Mundo", "rbxassetid://13529340637")

tabMundo.newLabel("Controles do Ambiente")

-- Slider para a Hora do Dia
tabMundo.newSlider("Hora do Dia", "Muda a hora do dia no jogo (0 a 24).", 24, false, function(value)
    game:GetService("Lighting").ClockTime = value
end)

-- Dropdown para mudar o céu (skybox)
tabMundo.newDropdown("Céu", "Muda o visual do céu.", {"Padrão", "Amanhecer", "Espaço"}, function(selectedOption)
    print("Céu alterado para: " .. selectedOption)
    -- NOTA: Para funcionar de verdade, você precisaria adicionar o código
    -- para criar e aplicar um novo Skybox com o ID correspondente.
    -- Exemplo: game.Lighting.Sky.SkyboxImage = "rbxassetid://ID_DA_IMAGEM"
end)

-- Input para enviar uma mensagem global (exemplo)
tabMundo.newInput("Anúncio Global", "Digite uma mensagem para anunciar.", function(text)
    if text and text ~= "" then
        print("[Anúncio do Hub]: " .. text)
        -- NOTA: Em um script real, isso dispararia um RemoteEvent para o servidor.
    end
end)


--================================================================
-- 4. ABA "CONFIGURAÇÕES" - OPÇÕES DA PRÓPRIA UI
--================================================================

local tabConfig = LoUILibrary.newTab("Configurações", "rbxassetid://13529334751")

tabConfig.newLabel("Configurações da Interface")

-- Slider para controlar a transparência da UI
-- O segundo argumento (true) em newSlider faz com que o texto seja gerenciado manualmente
tabConfig.newSlider("Transparência da UI", "Ajusta a transparência da janela.", 80, true, function(value, label)
    local transparencyValue = value / 100
    label.Text = string.format("%.2f", transparencyValue) -- Mostra o valor como 0.20
    window:SetTransparency(transparencyValue)
end)

-- Keybind para abrir e fechar o Hub
tabConfig.newKeybind("Abrir/Fechar Hub", "Define uma tecla para mostrar/esconder a UI.", function(input)
    print("Tecla para abrir/fechar o Hub definida como: " .. input.KeyCode.Name)
    -- A função :Toggle() já está conectada no botão de fechar,
    -- mas aqui você adicionaria a lógica para a tecla funcionar globalmente.
    -- Exemplo:
    -- UserInputService.InputBegan:Connect(function(key)
    --     if key.KeyCode == input.KeyCode then
    --         window:Toggle()
    --     end
    -- end)
end)

tabConfig.newButton("Reconectar", "Simula uma reconexão ao servidor.", function()
    print("Tentando reconectar...")
    -- Lógica de reconexão entraria aqui
end)

tabConfig.newButton("Sair do Jogo", "Desconecta você do jogo.", function()
    player:Kick("Você saiu do jogo através do Hub.")
end)
