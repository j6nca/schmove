GDPC                �                                                                         T   res://.godot/exported/133200997/export-234fb6894ec6226e856ab7f825500d3d-player.scn  �"      �      � ������	�+/m�6    X   res://.godot/exported/133200997/export-448090ec41b8fba68177e789cb5fd95a-test_scene.scn   D      �      �`�׊Ʉ�����;/u    X   res://.godot/exported/133200997/export-9504e89cdf9b14ad99ed376e57fd3ca9-trajectory.scn  �L      {      �⥟E<,�3��yS��    T   res://.godot/exported/133200997/export-ac840aa059c2bd348c49ef033023bbf1-satchel.scn �7      A      �K��vT�L�h&pZf��    ,   res://.godot/global_script_class_cache.cfg  �y             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexj      �      �Yz=������������    H   res://.godot/imported/player.png-e1eaffe0873063c60a0d0b322e4d87d9.ctex  �      �      �	<$�1��^�n[1$    H   res://.godot/imported/satchel.png-2a831b304759f6aba07112621aedf445.ctex  
      t      6�5i<��Pvk��1y    L   res://.godot/imported/test_texture.jpg-209a2bae9ef8899e0f8b4f5eaa6bb056.ctexP      �      �CVe#�3.��� n�+       res://.godot/uid_cache.bin  `}      ?      ����K��#i͘@�Q    $   res://assets/shaders/entity.gdshader        �      4�L�;L�Q¡�fF    (   res://assets/sprites/player.png.import  0	      �       Đ����(�Y2(U�G    (   res://assets/sprites/satchel.png.import �      �       �D���o�Rv�d�=�\_    ,   res://assets/sprites/test_texture.jpg.import�!      �       Fu�X*q4g�)6va       res://icon.svg  �y      �      C��=U���^Qu��U3       res://icon.svg.import   �v      �       p`6F��T�Z�O       res://project.binary�~      A      J��`��gb�WB��        res://scenes/player.tscn.remap  �w      c       2�A�Z͈�BJbB        res://scenes/satchel.tscn.remap 0x      d       x�)�\���A����    $   res://scenes/test_scene.tscn.remap  �x      g       :��^�Y=�����~�    $   res://scenes/trajectory.tscn.remap  y      g       +�d9W�>���p[Fk       res://scripts/player.gd O      `      ;�啀�Y?܄F����       res://scripts/satchel.gdp]      �
      -R���w��U h��       res://scripts/trajectory.gd 0h      �      \d�~��w�ː�#� �                shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform float width : hint_range(0, 10) = 1.0;
uniform int pattern : hint_range(0, 2) = 0; // diamond, circle, square
uniform bool inside = false;
uniform bool add_margins = true; // only useful when inside is false

void vertex() {
	if (add_margins) {
		VERTEX += (UV * 2.0 - 1.0) * width;
	}
}

bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, sampler2D texture) {
	for (float i = -ceil(width); i <= ceil(width); i++) {
		float x = abs(i) > width ? width * sign(i) : i;
		float offset;
		
		if (pattern == 0) {
			offset = width - abs(x);
		} else if (pattern == 1) {
			offset = floor(sqrt(pow(width + 0.5, 2) - x * x));
		} else if (pattern == 2) {
			offset = width;
		}
		
		for (float j = -ceil(offset); j <= ceil(offset); j++) {
			float y = abs(j) > offset ? offset * sign(j) : j;
			vec2 xy = uv + texture_pixel_size * vec2(x, y);
			
			if ((xy != clamp(xy, vec2(0.0), vec2(1.0)) || texture(texture, xy).a == 0.0) == inside) {
				return true;
			}
		}
	}
	
	return false;
}

void fragment() {
	vec2 uv = UV;
	
	if (add_margins) {
		vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / TEXTURE_PIXEL_SIZE + vec2(width * 2.0));
		
		uv = (uv - texture_pixel_size * width) * TEXTURE_PIXEL_SIZE / texture_pixel_size;
		
		if (uv != clamp(uv, vec2(0.0), vec2(1.0))) {
			COLOR.a = 0.0;
		} else {
			COLOR = texture(TEXTURE, uv);
		}
	} else {
		COLOR = texture(TEXTURE, uv);
	}
	
	if ((COLOR.a > 0.0) == inside && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
		COLOR.rgb = inside ? mix(COLOR.rgb, color.rgb, color.a) : color.rgb;
		COLOR.a += (1.0 - COLOR.a) * color.a;
	}
}    GST2   �   @      ����               � @        Z  RIFFR  WEBPVP8LE  /���&����㳂@ї�DI#IR�E+`Ͽ�����pԶm#H��2�mr��-  (������C���1������z+�eBp%�j��-���߭�Ly����#7���Kp����W�ω��t^� |� ���;\ί����^��]�f-ˢ���v�b��k�Y�^��xyoo��s�&���M�]��"���.A��"ZkA����u���8�w�{Y�Q�&���K������@�3���%Nɘл`��zAWH	�K�W��~��=��a/�v��2��.`v	��w����$��$�s�0_���6����I��z�{�wq{�� ���jz����!�<�W6 �%�+�{���k�57<��||� �Y˲���ݻ���z�W@o=^�[��+�ܲ�+ s�;f�%ý��4�Kл���֚A�Ễ{m�u]��5��]�^�lT�	�i���%Ũ�/P���D{ɃS2&�./�^�R���.�.����e��h��]"�L�+�y�?������$ĸ`��e����様��$��[����N��5�ʾ+��v�--��zL�jqh�C3o+��'��~$               [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://cvqjqri21ai4q"
path="res://.godot/imported/player.png-e1eaffe0873063c60a0d0b322e4d87d9.ctex"
metadata={
"vram_texture": false
}
              GST2   �   @      ����               � @        <  RIFF4  WEBPVP8L(  /�' H�7a#�`2�;�<���[2�"�G���H�6$�d2@� �����0��D�ߑ�6�Ī�Sό2�#.3+��;[Vtǹ���.ݱP ��
�թ�! ��^��P���YD�q &w*�V�;|�ԡ.�]k"b�a�߻����;��W;�7ӂ�3�ZL;�eE���'���9F��u�c�9��d��Q!|��|�;��@�ǿ=�=�s���9(�� &���gk�w8��Jf�nn���2d�,�	�����{��"�'��������9f�Z��            [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://g5tvgqgur6ht"
path="res://.godot/imported/satchel.png-2a831b304759f6aba07112621aedf445.ctex"
metadata={
"vram_texture": false
}
              GST2   �   �      ����               � �        P  RIFFH  WEBPVP8L;  /� 8 ��BD�SG A��6��m$�$<��� !��{�=h�{ߒ$Y�$ٖ��{D߿�����7e S����B�H�$O���?�G���6��}�x��$rj��rJ��?�P>P^�� �	�E'���p7 � �/���(�~�9`���G�	 ��\D��8�.�A�l[�P�N,� �<��Ѝ `��? B��$� 	1n�8��K7��n]Z";�b�@�\G�	<H72@pa4�$�����lkZ����K @B�$��"E�
�w\it-J�H=e�:x�w����<�G9}@��PHL��/ (���^�G�ڌ�p�N�X��,٧��� ��4�e���DJP@ P@,�ę�>�KZ"}Ou∠4����y!��Qxr���It�@BʘO 	�j%	��3��>����*B#(��F��P-�YC�.�i�ʋo��,y ���a��'�p�0l�/���<���"��F��I@".R�T
0ؑ>�yE1l������_�3obĬ�}*c��*|$G��lx���BH��*�3��/�	lT�$>;ݬ9����g�M;��*�Sp�� �٥�Ʌ �A>�9�,���wI����N����Ƨ{����_|\~�u�u	@Q��� �t=U.����g1��y~;��=Vb�"�`��9!��U���:�t8܆`Adp�O�,��)!�zr��_����	50��2u �V\��E�?)���^z�u���%ԩ|!E���^��,~����7�:/��X@A��>"UIy@�� ��o� �%�t/R�yU�d�D���š���
(�.t�ֽ�1�:�\�L d�=(������k�[@�� ��S�A���F�]C N��+NHCP^8n�CZlA	3ҨqS�0�n=��'q�!���'
8BB��*�0}[�1 ��C�	�H& 0� 9�$#@�J��	B�&�A�*Q����b���;B`� �����'��/�	�:�������ǇA�� BЃi�=����ƞ��f���$u�����&���/�+�t"b�bՍ���Q���N<�)-$1�B�H尀�g�E^��9�<�`�[�x/���e�䑛��,��6�tRR4�H�8�M�����LI9&Q�8���JRG�Z#�7��R���F����Ɠ���J20���J��xa.}�ί����\Jb��p|���BH�4:��RB.�{�,6!	wE���ՙH��`N��5�@ P'�nN��A��M� A��<7 �b�F6z��B �Rd` ��p�-���ف:W�1\ B���['��f�H����~�iS���M c>����>�����5R�����1 5bHfD����
W��ǂ>0��������@�D�t6a����m8@�P�0S�{��K�%5����L:��z��%5�����Tkx��m�c@���l�a"��B��6>Jă�a)֌n�462|d j�X����\]���#�꾸���va��>g�) �d*��Hx"���nppr�����&�P� ��1�	"xK�b�Bs]�G���\�K$���D @ ·�od���������?�"��K*�����5��	d��wـܳ��/ہ}&���c�!���c�<s�e���(B��8p	A����t7x � |��~��"(�q����_�mA\Ꭼ Ƞ{)Dx�}sr𚕯�'���` 2y٣��`ڈ��)�U�sL*�Y�����E ��wA�5��R�Q^��ǅ��efwD �. i&���Ќ5�fL�@�o'��KO�-�����1`r��n�|�Ta����F���Z�o�q�XT�1 � pb9:�!S\9 �4!��p�Ģ*��B�����
')�I�N�Ee��nd��x�'^ش�� � Ex1gRI9F��6�W�FW�r�2~�ɴ���S��Rr���Z*X�"K |��3��{"�:�>�'1�b~`����[�)u���P���A?U/_��{�Bˬ��gnXy#F�3�\��
�p����� ���D8B"lґ�4�@p�g�G'(ƺ9i4��S�H'B��6�U�,|T0��B㇒��}�
 �Qi�	�`��)^�����8i<0N ˤ�{@��`�C�XKRB �/�	��M��:��52���h��Z��@BU1 �d�H%�ݢ�"@ [�̄Aɥ��	'� �"���9=ڢ\��EG|$�^����bdlr;��$�����o�J���yH�C��5(�a�
�
ؠk\�M�&�3��F�U�M��m�$E � +p兠<@�E�� �9D��VR��A�|�8^b��L!���[!�%�'��U@ɭS�" ��i8P�z��V�"�hB��I��7ں��";f�I�@�]� ��\d睍ȴ�čdd`�P�w@�:�
 )�T���:6n˥��`�̓9x�iZ3Eۏ�z	�1Ve#�:Eh���#I�=<6Wny驓�C����H��b�O�|'^ǘ��%1$��L��1����Po!y�{B�J�eSFd����*�@6X�f�5�Oa�t���a� �2��)~���Lv`�����`�K�<�$��
2�(��	��5��3�;f��p����Dw!h#,'E���9x�/�Z P�Ӛ��`X��^{%�Tb�Ġ��d `M�8c�I.�f�`���{;ב�2ɼ̘�k�����p�	��Țp��yy�ϙ��½л�� �V.k/i�rPX��]��9�(@��'�F�4�'�<�l���Ԍ笴(6���E�,�**�G����:Z9��bC��Cգז܅�C?`&^��G�q�-2�IP�Ho  %{����L���0Σ�	c%(�Ճ�Y!�����2Ǻ,�%(�p �^H�.���H�Ѧ\#�>����Mh(Ґ�	�NX|��g�`O�#�'�`2;ﴀ[/��
2+6��t�]�/�7��X��A���f�Mq�J��&]oAx�t>��p�A��Ke@���1�B�BH��������\�7}#`]���'p��F��)���} �K�	X���t��\mI�V�� w]�B�3A�w`��tu@��e�xw;�/	�o�Z���HS����(����=Ǭ�؈�K��Hp���������=g%R��+�ߣ�윟��"��{��F�:�E����72a� 2�s�p��^g�[�в��N? F��S3�A`�����^�ަ�{a�K��|��^�dp2	�L��6�^_L�/%̀�+aQ���i2n�%e&F�e"$/�^�X^�,QKۨ�����̌Y���0�s,���70&�	$������܈5��`�ܣ+M���V� 9ǢFF���yv�`�W���^f
��+��N9�+J"'B����q�O�P�����h���P��	'���I =j��=L`b2Bfk#c�gj K؀�fj!�D��ҿ`�p�u��9{�2� �\�8���ّI�"g�<q�y;�w�n�H ���c\y�ֵ:qD�3�j�+Ù6�	(r��{A�~�$3���^Im9Q4Nk�:V�pk>y�����J� 
\&rI���a*vm���!2�h��?�����F�J��k��6R0�+q���7�������[z�;0``�h�(2"bߴ3�����{���o.N0Yѳ�G'�,�pm�⩟BB�����¬[h���ҡ��q7 #����@�& ���W�y�� �S���i�4����L�>��9O�.��z�@Q ^�bF�s��"R�&��6�?BB^� �F,�3�ƿr�3�WcB��	[�P��R���G��BE?��cS�! @X�m4 ��?�/���'^p�S�C�C@fս�0Ԅ/� �'�2d�ځ�+H�:��[�%����O�6'�8X�)'w����5�a�z�uJ��9�����p��a��LH%= 
�L?Y��$��r=&�s`�R�`µ&JH�*�=(X�p#��dD>$� [v٠ �*�:�M;�l��H@L��	;S�!�s���jY���CRL�����
# ɫ��>�Q��(���iDx�'�l�A��f��-#p7��?��t I�t���;�y�������J ��F恁I�;��Σ�<D���ȼ@ @ @���?��#��?߰����K�}�V�� �zI���(EH%�Y�l���/ (W~	o8.rEV�"GF2���c��8���~.I�Y�O��DV�ͮ D�"}�
�9����x1x���� a��pMۏ�߉4vto���>	�IS�Ttd�P!� �7S�`���aJGH�_��w8C^D��2;$��w2�Z�po>r�qǸ�w����.��G u���@Ɇ�&\�.ϑ8M����@5,�<-�"�y��<� ,}���Yf���kyN��4o�<������Ӿ�~�@� @�@����h��:sm9���^�pp�.
���@6�f7p�Bj���7�@�9�!�K�m'el�@gj�@p���a�!(�İ��4������?I2%�S,������7P����ƞ)�d��F�t�M�D`݃X���� ���]Qq�-6��I/H���8`��hd��uD�@��oP�{�0|��B��q� ���}B��"��Sw����\1����b���ՈaN�0 �#�<���PϕJ�4���b�d���x=΃f&J��(;f>�O^4ɹvI�-聏�VB#mT�Z�������R�Z4�$� �� l��H����.�O ϳ@@aA�2yD@�H�5��6sw�3�CJ\w�p�j9r��N56R�v~	�,��"����s�X�:����9r�8u'����⑼���K2�> �T�6�"�[�rCA�cMdL� �>����kab@b��q�0܁���u�	�R��b
xs]���#c-@*wdZG|��u�b�7���B��� ��G��@�Fy�rQ  �|j��(O��� �A��|s���D�E���O^O~x"V ��y�Q|���o����[)>9i(V�pf*��D���/'O���'/>�/�\z�yҗ�)F�"4~��O~8З@H{K�&�C�]L�i��|#XPJ��D'��         [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ywnycct6ywb"
path="res://.godot/imported/test_texture.jpg-209a2bae9ef8899e0f8b4f5eaa6bb056.ctex"
metadata={
"vram_texture": false
}
          RSRC                    PackedScene            ��������                                            6   	   Sprite2D    frame    ..    AnimationPlayer    resource_local_to_scene    resource_name    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    script    _data    custom_solver_bias    size 
   animation 
   play_mode    blend_point_0/node    blend_point_0/pos    blend_point_1/node    blend_point_1/pos 
   min_space 
   max_space    snap    value_label    blend_mode    sync    xfade_time    xfade_curve    reset 	   priority    switch_mode    advance_mode    advance_condition    advance_expression    state_machine_type    allow_transition_to_self    reset_ends    states/End/node    states/End/position    states/Start/node    states/Start/position    states/idle/node    states/idle/position    states/walk/node    states/walk/position    transitions    graph_offset 	   _bundled       Script    res://scripts/player.gd ��������
   Texture2D     res://assets/sprites/player.png ��D,g�(W      local://Animation_kktjj �         local://Animation_ic3gk �         local://Animation_hnv0l �	         local://AnimationLibrary_dske0          local://RectangleShape2D_xlsbx �      %   local://AnimationNodeAnimation_egss1 �      %   local://AnimationNodeAnimation_1leoq �      (   local://AnimationNodeBlendSpace1D_n8s50 .      %   local://AnimationNodeAnimation_0rprh �      %   local://AnimationNodeAnimation_27nfu �      (   local://AnimationNodeBlendSpace1D_ttglm        2   local://AnimationNodeStateMachineTransition_lxktc b      2   local://AnimationNodeStateMachineTransition_y7auj �      2   local://AnimationNodeStateMachineTransition_iobd1 �      (   local://AnimationNodeStateMachine_ppo7o D         local://PackedScene_bqqsi M      
   Animation 	         o�:	         value 
                                                                   times !                transitions !        �?      values                    update             
   Animation             idle       ���?         	         value 
                                                                   times !          ���>��?fff?      transitions !        �?  �?  �?  �?      values                                      update             
   Animation             walk       ���>         	         value 
                                                                   times !          ���=��L>���>      transitions !        �?  �?  �?  �?      values                                     update                AnimationLibrary                   RESET                 idle                walk                   RectangleShape2D       
      A  hA         AnimationNodeAnimation       ,      idle          AnimationNodeAnimation       ,      idle          AnimationNodeBlendSpace1D                        ��                    �?         AnimationNodeAnimation       ,      walk          AnimationNodeAnimation       ,      walk          AnimationNodeBlendSpace1D                        ��         	           �?      $   AnimationNodeStateMachineTransition    %               $   AnimationNodeStateMachineTransition    %         &   ,      walk       $   AnimationNodeStateMachineTransition    %         &   ,      idle          AnimationNodeStateMachine 	   +      -      .   
     IC  �B/            0   
    ��C  �B1         
   2   
     D  �B3      	         Start       idle                idle       walk                walk       idle                   PackedScene    5      	         names "         Player    collision_layer    collision_mask    script    CharacterBody2D 	   Sprite2D    texture    hframes    vframes    AnimationPlayer 
   libraries    CollisionShape2D 	   position    shape    AnimationTree 
   tree_root    anim_player    active    parameters/conditions/idle    parameters/conditions/walk    parameters/idle/blend_position    parameters/walk/blend_position 	   Camera2D    zoom    Explosion_Timer 
   wait_time    Timer    Recharge_Timer    _on_explosion_timer_timeout    timeout    _on_recharge_timer_timeout    	   variants                                                                   
         @?                                           )   ��d9	�)   #��ݯ��
     �@  �@     �>      node_count             nodes     \   ��������       ����                                         ����                                 	   	   ����   
                        ����                                 ����            	      
                                             ����                           ����                           ����              conn_count             conns                                                              node_paths              editable_instances              version             RSRC            RSRC                    PackedScene            ��������                                               	   Sprite2D    frame    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    _data    radius 	   _bundled       Script    res://scripts/satchel.gd ��������
   Texture2D !   res://assets/sprites/satchel.png �`#l�      local://RectangleShape2D_4n67e /         local://Animation_yvrvj `         local://Animation_vgrum X         local://Animation_lsym1 �         local://AnimationLibrary_ag4ku �         local://CircleShape2D_kl3nd Y         local://PackedScene_1kyrc �         RectangleShape2D       
     �@  �@      
   Animation 	         o�:
         value                                                                    times !                transitions !        �?      values                    update             
   Animation 
         
   explosion       ���>
         value                                                                    times !          ���=��L>���>      transitions !        �?  �?  �?  �?      values                                     update             
   Animation             idle       ��L?         
         value                                                                    times !          ��L>���>��?      transitions !        �?  �?  �?  �?      values                                      update                AnimationLibrary                   RESET             
   explosion                idle                   CircleShape2D            �A         PackedScene          	         names "         Satchel    collision_layer    collision_mask    script    RigidBody2D 	   Sprite2D    texture    hframes    vframes    CollisionShape2D    shape    Self_Detonate_Timer    Timer    AnimationPlayer 
   libraries 
   RayCast2D    Explosion_Area    Area2D    Explosion_Shape     _on_self_detonate_timer_timeout    timeout     _on_explosion_area_body_entered    body_entered    _on_explosion_area_body_exited    body_exited    	   variants                                                                                            node_count             nodes     N   ��������       ����                                         ����                                 	   	   ����   
                        ����                      ����                           ����                      ����                            	      ����   
                conn_count             conns                                                                                      node_paths              editable_instances              version             RSRC               RSRC                    PackedScene            ��������                                            	      resource_local_to_scene    resource_name    custom_solver_bias    size    script    blend_mode    light_mode    particles_animation 	   _bundled    
   Texture2D &   res://assets/sprites/test_texture.jpg ���1ڴ    PackedScene    res://scenes/player.tscn Èj��      local://RectangleShape2D_1t5fi Y      !   local://CanvasItemMaterial_askkj �         local://RectangleShape2D_swnse �         local://RectangleShape2D_syq1g �         local://PackedScene_m7tty          RectangleShape2D       
     UD  �A         CanvasItemMaterial             RectangleShape2D       
     �@ @WB         RectangleShape2D       
     �B  pA         PackedScene          	         names "         World    Node2D    Floor    collision_mask    StaticBody2D    CollisionShape2D 	   position    shape 	   Sprite2D    scale    texture    Wall 	   material    CollisionShape2D2 
   Sprite2D3    Player 
   Platforms 
   Sprite2D2    	   variants             
      A  \B          
     (A  \B
   ��r@b�=                   
      �4�~A         
     C  �A
      �  �A
    t�<	x>                
     XC  X�         
     DB  \�
     DB  ^�
   �Y�>���=      node_count             nodes     �   ��������       ����                      ����                           ����                                ����         	      
                        ����                           ����                                      ����            	                          ����      
   	      
                       ����      	   	      
                  ���                            ����             
             ����                   
             ����                   
             ����         	      
          
             ����         	      
                conn_count              conns               node_paths              editable_instances              version             RSRC           RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://scripts/trajectory.gd ��������      local://PackedScene_bpq6l          PackedScene          	         names "         Trajectory    script    Line2D    	   variants                       node_count             nodes     	   ��������       ����                    conn_count              conns               node_paths              editable_instances              version             RSRC     extends CharacterBody2D


const BASE_SPEED = 100.0
const BASE_JUMP_VELOCITY = -200.0
const BASE_SLIME_CHARGES = BASE_MAX_CHARGES
const BASE_OUTLINE = Vector4(0.2, 0.2, 0.2, 1.0)
const BASE_MAX_CHARGES = 102
const BASE_LIVE_CHARGES = 1
const BASE_THROW_VELOCITY = Vector2(10,0)

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var shader = preload("res://assets/shaders/entity.gdshader")
@onready var character : CharacterBody2D = $Player
@onready var Satchel = preload("res://scenes/satchel.tscn")
@onready var explosion_timer : Timer = $Explosion_Timer
@onready var recharge_timer : Timer = $Recharge_Timer
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction = 1
var speed = BASE_SPEED
var jump_velocity = BASE_JUMP_VELOCITY
var slime_charges = BASE_SLIME_CHARGES
var max_charges = BASE_MAX_CHARGES
var base_live_charges = BASE_LIVE_CHARGES
var available_charges = BASE_MAX_CHARGES
var explosion = Vector2.ZERO

func set_explosion(force: Vector2):
	explosion = force
	explosion_timer.wait_time = 0.1
	explosion_timer.start()

func _ready():
	add_to_group("player")
	# Set collision data
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)

	# Set shaders
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = shader
	sprite.material.set_shader_parameter("color", BASE_OUTLINE)
	# Start recharge timer
	recharge_timer.wait_time = 2
	recharge_timer.start()
	
func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/walk"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/walk"] = true	

func _process(delta):
	update_animation_parameters()
	sprite.scale.x = last_direction
		
func _physics_process(delta):
	if Input.is_action_just_pressed("throw"):
		satchel()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input = Input.get_axis("move_left", "move_right")
	var direction = sign((get_global_mouse_position() - global_position).x)
	last_direction = direction
	velocity.x = input * speed
	velocity += explosion
	
	move_and_slide()

func satchel():
	# Check if satchel exists, if so, then follow up action is to detonate, else throw satchel
	# TODO: have an area of effect for satchel vector
	# TODO: only move player if satchel can see player (ray cast?)
	var satchels = get_tree().get_nodes_in_group("satchels")
	if satchels.size() + 1 > base_live_charges:
		print("satchel exists")
		for satchel in satchels:
			satchel.detonate()
	elif available_charges > 0:
		print("throwing slime...")
		var satchel = Satchel.instantiate()
		get_parent().add_child(satchel)
		var throw_direction = (get_global_mouse_position() - global_position).normalized()
		print(throw_direction)
		satchel.position = Vector2(position.x, position.y)
		satchel.velocity = satchel.BASE_THROW_SPEED * throw_direction + BASE_THROW_VELOCITY
		available_charges -= 1
	
func _on_explosion_timer_timeout():
	explosion = Vector2.ZERO

func _on_recharge_timer_timeout():
	if available_charges < max_charges:
		print("Charge refilled")
		available_charges += 1
	else:
		print("Charge full")
	recharge_timer.start() # Replace with function body.
extends RigidBody2D

@onready var detonate_timer : Timer = $Self_Detonate_Timer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var explosion_area : Area2D = $Explosion_Area
@onready var explosion_shape : CollisionShape2D = $Explosion_Area/Explosion_Shape
@onready var raycast : RayCast2D = $RayCast2D
@onready var shader = preload("res://assets/shaders/entity.gdshader")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.1
var velocity = Vector2.ZERO
var explosion_strength = BASE_EXPLOSION_STRENGTH
var in_player_vicinity = false
var in_player_los = false

const BASE_THROW_SPEED = 150
const BASE_TIME_TO_DETONATE = 3
const BASE_OUTLINE = Vector4(0.2, 0.2, 0.2, 1.0)
const BASE_EXPLOSION_STRENGTH = 50.0
const BASE_EXPLOSION_RADIUS = 25
 

func _ready():
	# Add satchel instances to a group - there should only be one at a time
	add_to_group("satchels")
	# Set base constants
	velocity = BASE_THROW_SPEED * velocity
	# Set collision data
	set_collision_layer_value(3, true)
	set_collision_mask_value(1, true)
	explosion_area.set_collision_mask_value(2, true)
	# Set explosion radius
	var shape = CircleShape2D.new()
	shape.radius = BASE_EXPLOSION_RADIUS
	explosion_shape.shape = shape
	# Set animation
	animation_player.play("idle")
	# Set timer
	detonate_timer.wait_time = BASE_TIME_TO_DETONATE
	detonate_timer.start()
	# Set shaders
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = shader
	sprite.material.set_shader_parameter("color", BASE_OUTLINE)

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_collide(velocity * delta)
	raycast.set_target_position(get_parent().get_node("Player").position - position)
	if raycast.is_colliding():
		in_player_los = false
	else:
		in_player_los = true
		
	
func detonate():
	#detonate logic here
	remove_from_group("satchels")
	var player_pos = get_parent().get_node("Player").global_position
	var explosion_vector = (player_pos - global_position).normalized()
	explosion_vector = Vector2(explosion_vector.x * 10, explosion_vector.y)
	# print("satchel: ", global_position)
	# print("player: ", player_pos)
	#print("resulting", explosion_vector)
	print(in_player_vicinity)
	if in_player_vicinity and in_player_los:
		get_parent().get_node("Player").set_explosion(explosion_vector * explosion_strength)
		
	animation_player.play("explosion")
	await animation_player.animation_finished
	queue_free()

func _on_self_detonate_timer_timeout():
	detonate()


func _on_explosion_area_body_entered(body):
	print(body.name)
	if body.name == "Player":
		in_player_vicinity = true


func _on_explosion_area_body_exited(body):
	if body.name == "Player":
		in_player_vicinity = false
    extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func update_trajectory(dir: Vector2, speed: float, delta):
	var max_points = 50
	clear_points()
	var pos: Vector2 = Vector2.ZERO
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
   GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح����mow�*��f�&��Cp�ȑD_��ٮ}�)� C+���UE��tlp�V/<p��ҕ�ig���E�W�����Sթ�� ӗ�A~@2�E�G"���~ ��5tQ#�+�@.ݡ�i۳�3�5�l��^c��=�x�Н&rA��a�lN��TgK㼧�)݉J�N���I�9��R���$`��[���=i�QgK�4c��%�*�D#I-�<�)&a��J�� ���d+�-Ֆ
��Ζ���Ut��(Q�h:�K��xZ�-��b��ٞ%+�]�p�yFV�F'����kd�^���:[Z��/��ʡy�����EJo�񷰼s�ɿ�A���N�O��Y��D��8�c)���TZ6�7m�A��\oE�hZ�{YJ�)u\a{W��>�?�]���+T�<o�{dU�`��5�Hf1�ۗ�j�b�2�,%85�G.�A�J�"���i��e)!	�Z؊U�u�X��j�c�_�r�`֩A�O��X5��F+YNL��A��ƩƗp��ױب���>J�[a|	�J��;�ʴb���F�^�PT�s�)+Xe)qL^wS�`�)%��9�x��bZ��y
Y4�F����$G�$�Rz����[���lu�ie)qN��K�<)�:�,�=�ۼ�R����x��5�'+X�OV�<���F[�g=w[-�A�����v����$+��Ҳ�i����*���	�e͙�Y���:5FM{6�����d)锵Z�*ʹ�v�U+�9�\���������P�e-��Eb)j�y��RwJ�6��Mrd\�pyYJ���t�mMO�'a8�R4��̍ﾒX��R�Vsb|q�id)	�ݛ��GR��$p�����Y��$r�J��^hi�̃�ūu'2+��s�rp�&��U��Pf��+�7�:w��|��EUe�`����$G�C�q�ō&1ŎG�s� Dq�Q�{�p��x���|��S%��<
\�n���9�X�_�y���6]���մ�Ŝt�q�<�RW����A �y��ػ����������p�7�l���?�:������*.ո;i��5�	 Ύ�ș`D*�JZA����V^���%�~������1�#�a'a*�;Qa�y�b��[��'[�"a���H�$��4� ���	j�ô7�xS�@�W�@ ��DF"���X����4g��'4��F�@ ����ܿ� ���e�~�U�T#�x��)vr#�Q��?���2��]i�{8>9^[�� �4�2{�F'&����|���|�.�?��Ȩ"�� 3Tp��93/Dp>ϙ�@�B�\���E��#��YA 7 `�2"���%�c�YM: ��S���"�+ P�9=+D�%�i �3� �G�vs�D ?&"� !�3nEФ��?Q��@D �Z4�]�~D �������6�	q�\.[[7����!��P�=��J��H�*]_��q�s��s��V�=w�� ��9wr��(Z����)'�IH����t�'0��y�luG�9@��UDV�W ��0ݙe)i e��.�� ����<����	�}m֛�������L ,6�  �x����~Tg����&c�U��` ���iڛu����<���?" �-��s[�!}����W�_�J���f����+^*����n�;�SSyp��c��6��e�G���;3Z�A�3�t��i�9b�Pg�����^����t����x��)O��Q�My95�G���;w9�n��$�z[������<w�#�)+��"������" U~}����O��[��|��]q;�lzt�;��Ȱ:��7�������E��*��oh�z���N<_�>���>>��|O�׷_L��/������զ9̳���{���z~����Ŀ?� �.݌��?�N����|��ZgO�o�����9��!�
Ƽ�}S߫˓���:����q�;i��i�]�t� G��Q0�_î!�w��?-��0_�|��nk�S�0l�>=]�e9�G��v��J[=Y9b�3�mE�X�X�-A��fV�2K�jS0"��2!��7��؀�3���3�\�+2�Z`��T	�hI-��N�2���A��M�@�jl����	���5�a�Y�6-o���������x}�}t��Zgs>1)���mQ?����vbZR����m���C��C�{�3o��=}b"/�|���o��?_^�_�+��,���5�U��� 4��]>	@Cl5���w��_$�c��V��sr*5 5��I��9��
�hJV�!�jk�A�=ٞ7���9<T�gť�o�٣����������l��Y�:���}�G�R}Ο����������r!Nϊ�C�;m7�dg����Ez���S%��8��)2Kͪ�6̰�5�/Ӥ�ag�1���,9Pu�]o�Q��{��;�J?<�Yo^_��~��.�>�����]����>߿Y�_�,�U_��o�~��[?n�=��Wg����>���������}y��N�m	n���Kro�䨯rJ���.u�e���-K��䐖��Y�['��N��p������r�Εܪ�x]���j1=^�wʩ4�,���!�&;ج��j�e��EcL���b�_��E�ϕ�u�$�Y��Lj��*���٢Z�y�F��m�p�
�Rw�����,Y�/q��h�M!���,V� �g��Y�J��
.��e�h#�m�d���Y�h�������k�c�q��ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[          [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://bmfldw0rrwrph"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-234fb6894ec6226e856ab7f825500d3d-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-ac840aa059c2bd348c49ef033023bbf1-satchel.scn"
            [remap]

path="res://.godot/exported/133200997/export-448090ec41b8fba68177e789cb5fd95a-test_scene.scn"
         [remap]

path="res://.godot/exported/133200997/export-9504e89cdf9b14ad99ed376e57fd3ca9-trajectory.scn"
         list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             ��D,g�(W   res://assets/sprites/player.png�`#l�    res://assets/sprites/satchel.png���1ڴ %   res://assets/sprites/test_texture.jpgÈj��   res://scenes/player.tscniQ��X�Lu   res://scenes/satchel.tscn(�?LD�   res://scenes/test_scene.tscn�#TtP��d   res://scenes/trajectory.tscn�w����,   res://icon.svg ECFG      application/config/name         schmove    application/run/main_scene$         res://scenes/test_scene.tscn   application/config/features(   "         4.1    GL Compatibility       application/config/icon         res://icon.svg     input/move_left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/move_right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script         input/move_up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script         input/move_down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode    s      echo          script         input/throw�              deadzone      ?      events              InputEventMouseButton         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          button_mask          position     �B  �A   global_position      �B  |B   factor       �?   button_index         canceled          pressed          double_click          script      
   input/jump�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script         input/detonate�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   E   	   key_label             unicode    e      echo          script         layer_names/2d_physics/layer_1         World      layer_names/2d_physics/layer_2         Player     layer_names/2d_physics/layer_3         Projectiles 9   rendering/textures/canvas_textures/default_texture_filter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility               