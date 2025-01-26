shader_type canvas_item;

uniform sampler2D grass_texture;
uniform float tiling_factor : hint_range(0, 5.0) = 2.0;
uniform float random_strength : hint_range(0.0, 1.0) = 0.5;
uniform float time_factor : hint_range(0.0, 10.0) = 1.0;

void fragment() {
    // Pega as coordenadas UV da fragmentação
    vec2 uv = UV;//FRAGCOORD.xy / TEXTURE_PIXEL_SIZE;

    // Ajusta o fator de tiling (repetição) com base na entrada do usuário
    uv *= tiling_factor;

    // Adiciona variação aleatória ao deslocamento das coordenadas UV
    float random_offset = sin(uv.x * 10.0 + TIME * time_factor) * random_strength;
    uv.x += random_offset;
    uv.y += random_offset;

    // Garantir que as coordenadas UV ainda fiquem dentro dos limites (uvs [0,1])
    uv = mod(uv, 1.0);

    // Amostra a textura de grama com a UV modificada
    vec4 grass_color = texture(grass_texture, uv);

    // Opcionalmente, podemos adicionar variação de opacidade para mais naturalidade
    grass_color.a *= 0.5 + 0.5 * sin(uv.x * 50.0 + TIME * random_strength);

    // Retorna a cor final do pixel
    COLOR = grass_color;
}