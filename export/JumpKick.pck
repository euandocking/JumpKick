GDPC                                                                            +   @   res://.import/block.png-5bbcdacea06057fdfa5559fd03e54f2c.stex   �n      �       S0͵�f� "��{��@   res://.import/enemy.png-03f80dfd1208a1b3024d79304d31759f.stex   pr      �       |����r���D   res://.import/enemy_dead.png-29de2c2a30d987039d5c4be0a6f6a987.stex  �u      �       �͈���"�J��Zڵ<   res://.import/exit.png-f7467592b670edf91e317e4d1b376de1.stex y      X       ܶ���oC�{3G
&�<   res://.import/icon.png-82ea131e750a89467e27b5ff9b11ce77.stex0|      �      �'��.��}���Q�H   res://.import/one_way_platform.png-1b8121d5bc3374479d8a0f5476f905b7.stex��      V       Ϲ�B'C�����b�@   res://.import/player.png-f534b8a02ffb80eefc72936296201445.stex  ��      �       t^��r|�6�L+��L   res://.import/player_kick_ready.png-254207c06b6dfd71e21c726a6bd82ec7.stex   p�      �        �
,�g�7���@�#�<   res://.import/tile.png-c98d57e832a262fb2a654d7968b27450.stex�      B       x��$j��Q�\�-fi�,   res://addons/godot-git-plugin/git_api.gdnlib�      p      F����Xܷ�Ue�)g,   res://addons/godot-git-plugin/git_api.gdns               e8���"���l{!��   res://default_env.tres  @      �       um�`�N��<*ỳ�8   res://project.binaryP�      �	      ��o�d���Y��D�   res://scenes/Block.tscn �      �      ��Z�T�.82z0��   res://scenes/Enemy.tscn �      �      GD�  ��.
���v�   res://scenes/Exit.tscn  �      �      ��V�!WjBJINas��   res://scenes/Level.tscn 0      �      �����i5��#�mD�$    res://scenes/OneWayPlatform.tscn 1      �      �ez�*�%\e�4?P$�   res://scenes/Player.tscn 3      �	      ��nbj�H�t!��m   res://scripts/Actor.gd.remap�      (       J�^sG-�Ų�e��+   res://scripts/Actor.gdc �<      s      S�gC�����\*�   res://scripts/Block.gd.remap@�      (       �4��YuU����"�   res://scripts/Block.gdc @A      �      ��Y�S��뿾���   res://scripts/Enemy.gd.remapp�      (       �k��G$2��($d�:�   res://scripts/Enemy.gdc @D      �      �n?Uh�����v6Y$   res://scripts/EnemyHandler.gd.remap ��      /       :�Ķeu��Ι�HJ�    res://scripts/EnemyHandler.gdc  0T      i      H�ܢ��U��E�ӷ�   res://scripts/Exit.gd.remap В      '       ױ��Wگ�"��XD:   res://scripts/Exit.gdc  �V      h      ��ݗv�XQ+�0|��$   res://scripts/MainCamera.gd.remap    �      -       ���M���!�v&j   res://scripts/MainCamera.gdcY      (      Uq�LA9�����6�=�]    res://scripts/Player.gd.remap   0�      )       �g��і��CY�e�<e�   res://scripts/Player.gdc@Z      |      �@2��lC?(Fk~q�    res://sprites/block.png.import  �o      �      �27�V�I�@9cI)�B    res://sprites/enemy.png.import   s      �      �����}X�r$   res://sprites/enemy_dead.png.import @v      �      Ջ-�e���D|އxb    res://sprites/exit.png.import   `y      �      �72��0�vEEs���#   res://sprites/icon.png  `�      �      G1?��z�c��vN��    res://sprites/icon.png.import   �      �      �L�8�����99Us߾,   res://sprites/one_way_platform.png.import    �      �      N��/c
�=�����+��    res://sprites/player.png.import ��      �      �`���q'�	�J4���,   res://sprites/player_kick_ready.png.import  0�      �      8X���Tݘ�^:�4�    res://sprites/tile.png.import   `�      �      �	|i9�)%"T�YP��-    [general]

singleton=true
load_once=true
symbol_prefix="godot_"
reloadable=false

[entry]

OSX.64="res://addons/godot-git-plugin/osx/release/libgitapi.dylib"
Windows.64="res://addons/godot-git-plugin/win64/release/libgitapi.dll"
X11.64="res://addons/godot-git-plugin/x11/release/libgitapi.so"

[dependencies]

OSX.64=[  ]
Windows.64=[  ]
X11.64=[  ]
[gd_resource type="NativeScript" load_steps=2 format=2]

[ext_resource path="res://addons/godot-git-plugin/git_api.gdnlib" type="GDNativeLibrary" id=1]

[resource]
resource_name = "GitAPI"
class_name = "GitAPI"
library = ExtResource( 1 )
script_class_name = "GitAPI"
            [gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
             [gd_scene load_steps=5 format=2]

[ext_resource path="res://sprites/block.png" type="Texture" id=1]
[ext_resource path="res://scripts/Block.gd" type="Script" id=2]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 32, 32 )

[sub_resource type="RectangleShape2D" id=2]
extents = Vector2( 33, 33 )

[node name="BlockBody" type="KinematicBody2D"]
collision_layer = 4
collision_mask = 6
script = ExtResource( 2 )

[node name="BlockSprite" type="Sprite" parent="."]
texture = ExtResource( 1 )

[node name="BlockCollision" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )

[node name="HitArea" type="Area2D" parent="."]
collision_layer = 0
collision_mask = 16

[node name="HitCollision" type="CollisionShape2D" parent="HitArea"]
shape = SubResource( 2 )

[connection signal="body_entered" from="HitArea" to="." method="_on_HitArea_body_entered"]
[connection signal="body_exited" from="HitArea" to="." method="_on_HitArea_body_exited"]
     [gd_scene load_steps=5 format=2]

[ext_resource path="res://sprites/enemy.png" type="Texture" id=1]
[ext_resource path="res://scripts/Enemy.gd" type="Script" id=2]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 32, 32 )

[sub_resource type="CircleShape2D" id=2]
radius = 450.0

[node name="EnemyBody" type="KinematicBody2D"]
collision_layer = 16
collision_mask = 2
script = ExtResource( 2 )

[node name="EnemySprite" type="Sprite" parent="."]
texture = ExtResource( 1 )

[node name="EnemyCollision" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )

[node name="DetectionArea" type="Area2D" parent="."]
collision_layer = 0

[node name="DetectionCollision" type="CollisionShape2D" parent="DetectionArea"]
shape = SubResource( 2 )

[connection signal="accelDirChanged" from="." to="." method="_on_EnemyBody_accelDirChanged"]
[connection signal="detectedPlayer" from="." to="." method="_on_EnemyBody_detectedPlayer"]
[connection signal="playerEscaped" from="." to="." method="_on_EnemyBody_playerEscaped"]
[connection signal="body_entered" from="DetectionArea" to="." method="_on_DetectionArea_body_entered"]
[connection signal="body_exited" from="DetectionArea" to="." method="_on_DetectionArea_body_exited"]
             [gd_scene load_steps=4 format=2]

[ext_resource path="res://sprites/exit.png" type="Texture" id=1]
[ext_resource path="res://scripts/Exit.gd" type="Script" id=2]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 32, 32 )

[node name="ExitArea" type="Area2D"]
collision_layer = 0
script = ExtResource( 2 )

[node name="ExitSprite" type="Sprite" parent="."]
texture = ExtResource( 1 )

[node name="ExitCollision" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )

[connection signal="body_entered" from="." to="." method="_on_ExitArea_body_entered"]
[connection signal="body_exited" from="." to="." method="_on_ExitArea_body_exited"]
               [gd_scene load_steps=13 format=2]

[ext_resource path="res://sprites/tile.png" type="Texture" id=1]
[ext_resource path="res://scenes/Player.tscn" type="PackedScene" id=2]
[ext_resource path="res://scenes/Block.tscn" type="PackedScene" id=3]
[ext_resource path="res://scenes/OneWayPlatform.tscn" type="PackedScene" id=4]
[ext_resource path="res://scenes/Enemy.tscn" type="PackedScene" id=5]
[ext_resource path="res://scripts/MainCamera.gd" type="Script" id=6]
[ext_resource path="res://scripts/EnemyHandler.gd" type="Script" id=7]
[ext_resource path="res://scenes/Exit.tscn" type="PackedScene" id=8]

[sub_resource type="ConvexPolygonShape2D" id=2]
points = PoolVector2Array( 64, 64, 0, 64, 0, 0, 64, 0 )

[sub_resource type="TileSet" id=1]
0/name = "tile.png 0"
0/texture = ExtResource( 1 )
0/tex_offset = Vector2( 0, 0 )
0/modulate = Color( 1, 1, 1, 1 )
0/region = Rect2( 0, 0, 64, 64 )
0/tile_mode = 0
0/occluder_offset = Vector2( 0, 0 )
0/navigation_offset = Vector2( 0, 0 )
0/shape_offset = Vector2( 0, 0 )
0/shape_transform = Transform2D( 1, 0, 0, 1, 0, 0 )
0/shape = SubResource( 2 )
0/shape_one_way = false
0/shape_one_way_margin = 1.0
0/shapes = [ {
"autotile_coord": Vector2( 0, 0 ),
"one_way": false,
"one_way_margin": 1.0,
"shape": SubResource( 2 ),
"shape_transform": Transform2D( 1, 0, 0, 1, 0, 0 )
} ]
0/z_index = 0

[sub_resource type="Curve2D" id=3]
_data = {
"points": PoolVector2Array( 0, 0, 0, 0, 1049, 533, 0, 0, 0, 0, 2072, 531 )
}

[sub_resource type="Curve2D" id=4]
_data = {
"points": PoolVector2Array( 0, 0, 0, 0, 2269, 526, 0, 0, 0, 0, 3515, 530 )
}

[node name="Level" type="Node2D"]

[node name="TileMap" type="TileMap" parent="."]
tile_set = SubResource( 1 )
collision_layer = 2
collision_mask = 0
format = 1
tile_data = PoolIntArray( 0, 0, 0, 1, 0, 0, 2, 0, 0, 3, 0, 0, 4, 0, 0, 5, 0, 0, 6, 0, 0, 7, 0, 0, 8, 0, 0, 9, 0, 0, 10, 0, 0, 11, 0, 0, 12, 0, 0, 13, 0, 0, 14, 0, 0, 15, 0, 0, 16, 0, 0, 17, 0, 0, 18, 0, 0, 19, 0, 0, 20, 0, 0, 21, 0, 0, 22, 0, 0, 23, 0, 0, 24, 0, 0, 25, 0, 0, 26, 0, 0, 27, 0, 0, 28, 0, 0, 29, 0, 0, 30, 0, 0, 31, 0, 0, 32, 0, 0, 33, 0, 0, 34, 0, 0, 35, 0, 0, 36, 0, 0, 37, 0, 0, 38, 0, 0, 39, 0, 0, 40, 0, 0, 41, 0, 0, 42, 0, 0, 43, 0, 0, 44, 0, 0, 45, 0, 0, 46, 0, 0, 47, 0, 0, 48, 0, 0, 49, 0, 0, 50, 0, 0, 51, 0, 0, 52, 0, 0, 53, 0, 0, 54, 0, 0, 55, 0, 0, 56, 0, 0, 57, 0, 0, 65536, 0, 0, 65593, 0, 0, 131072, 0, 0, 131129, 0, 0, 196608, 0, 0, 196665, 0, 0, 262144, 0, 0, 262148, 0, 0, 262201, 0, 0, 327680, 0, 0, 327684, 0, 0, 327695, 0, 0, 327696, 0, 0, 327712, 0, 0, 327713, 0, 0, 327714, 0, 0, 327737, 0, 0, 393216, 0, 0, 393220, 0, 0, 393231, 0, 0, 393249, 0, 0, 393273, 0, 0, 458752, 0, 0, 458756, 0, 0, 458809, 0, 0, 524288, 0, 0, 524292, 0, 0, 524345, 0, 0, 589824, 0, 0, 589825, 0, 0, 589826, 0, 0, 589827, 0, 0, 589828, 0, 0, 589829, 0, 0, 589830, 0, 0, 589831, 0, 0, 589832, 0, 0, 589833, 0, 0, 589834, 0, 0, 589835, 0, 0, 589836, 0, 0, 589837, 0, 0, 589838, 0, 0, 589839, 0, 0, 589840, 0, 0, 589841, 0, 0, 589842, 0, 0, 589843, 0, 0, 589844, 0, 0, 589845, 0, 0, 589846, 0, 0, 589847, 0, 0, 589848, 0, 0, 589849, 0, 0, 589850, 0, 0, 589851, 0, 0, 589852, 0, 0, 589853, 0, 0, 589854, 0, 0, 589855, 0, 0, 589856, 0, 0, 589857, 0, 0, 589858, 0, 0, 589859, 0, 0, 589860, 0, 0, 589861, 0, 0, 589862, 0, 0, 589863, 0, 0, 589864, 0, 0, 589865, 0, 0, 589866, 0, 0, 589867, 0, 0, 589868, 0, 0, 589869, 0, 0, 589870, 0, 0, 589871, 0, 0, 589872, 0, 0, 589873, 0, 0, 589874, 0, 0, 589875, 0, 0, 589876, 0, 0, 589877, 0, 0, 589878, 0, 0, 589879, 0, 0, 589880, 0, 0, 589881, 0, 0 )

[node name="Platforms" type="Node" parent="."]

[node name="OneWayPlatform" parent="Platforms" instance=ExtResource( 4 )]
position = Vector2( 1316, 353 )

[node name="OneWayPlatform2" parent="Platforms" instance=ExtResource( 4 )]
position = Vector2( 1688, 349 )

[node name="OneWayPlatform3" parent="Platforms" instance=ExtResource( 4 )]
position = Vector2( 2504, 357 )

[node name="OneWayPlatform4" parent="Platforms" instance=ExtResource( 4 )]
position = Vector2( 3224, 361 )

[node name="Blocks" type="Node" parent="."]

[node name="Block" parent="Blocks" instance=ExtResource( 3 )]
position = Vector2( 455, 519 )

[node name="Block2" parent="Blocks" instance=ExtResource( 3 )]
position = Vector2( 1499, 531 )

[node name="Enemies" type="Node" parent="."]
script = ExtResource( 7 )
PlayerPath = NodePath("../Player")

[node name="Enemy" parent="Enemies" instance=ExtResource( 5 )]
position = Vector2( 635, 503 )

[node name="Enemy2" parent="Enemies" instance=ExtResource( 5 )]
position = Vector2( 3226, 522 )
PatrolPath = NodePath("../../Paths/PatrolPath")

[node name="Enemy3" parent="Enemies" instance=ExtResource( 5 )]
position = Vector2( 1345, 530 )
PatrolPath = NodePath("../../Paths/PatrolPath2")

[node name="Paths" type="Node" parent="."]

[node name="PatrolPath" type="Path2D" parent="Paths"]
curve = SubResource( 3 )

[node name="PatrolPath2" type="Path2D" parent="Paths"]
curve = SubResource( 4 )

[node name="Exit" parent="." instance=ExtResource( 8 )]
position = Vector2( 3616, 544 )

[node name="Player" parent="." instance=ExtResource( 2 )]
position = Vector2( 149, 509 )

[node name="MainCamera" type="Camera2D" parent="."]
position = Vector2( 220, 368 )
current = true
script = ExtResource( 6 )

[connection signal="enemiesDefeated" from="Enemies" to="Exit" method="_on_Enemies_enemiesDefeated"]
[connection signal="died" from="Enemies/Enemy" to="Enemies" method="_on_Enemy_died"]
[connection signal="died" from="Enemies/Enemy2" to="Enemies" method="_on_Enemy_died"]
[connection signal="died" from="Enemies/Enemy3" to="Enemies" method="_on_Enemy_died"]
     [gd_scene load_steps=3 format=2]

[ext_resource path="res://sprites/one_way_platform.png" type="Texture" id=1]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 128, 16 )

[node name="PlatformBody" type="StaticBody2D"]
collision_layer = 8
collision_mask = 0

[node name="PlatformCollision" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )
one_way_collision = true

[node name="PlatformSprite" type="Sprite" parent="."]
texture = ExtResource( 1 )
        [gd_scene load_steps=7 format=2]

[ext_resource path="res://sprites/player.png" type="Texture" id=1]
[ext_resource path="res://scripts/Player.gd" type="Script" id=2]

[sub_resource type="RectangleShape2D" id=1]
extents = Vector2( 32, 32 )

[sub_resource type="RectangleShape2D" id=2]
extents = Vector2( 48, 32 )

[sub_resource type="RectangleShape2D" id=3]
extents = Vector2( 28, 28 )

[sub_resource type="RectangleShape2D" id=4]
extents = Vector2( 4, 32 )

[node name="PlayerBody" type="KinematicBody2D"]
collision_mask = 11
script = ExtResource( 2 )

[node name="PlayerSprite" type="Sprite" parent="."]
texture = ExtResource( 1 )

[node name="PlayerCollision" type="CollisionShape2D" parent="."]
shape = SubResource( 1 )

[node name="KickArea" type="Area2D" parent="."]
position = Vector2( 0, 32 )
collision_layer = 0
collision_mask = 20

[node name="KickCollision" type="CollisionShape2D" parent="KickArea"]
position = Vector2( 16, 0 )
shape = SubResource( 2 )

[node name="HurtArea" type="Area2D" parent="."]
collision_layer = 0
collision_mask = 16

[node name="HurtCollision" type="CollisionShape2D" parent="HurtArea"]
shape = SubResource( 3 )

[node name="LeftCheckArea" type="Area2D" parent="."]
position = Vector2( -36, 0 )
collision_layer = 0
collision_mask = 2

[node name="LeftCheckCollision" type="CollisionShape2D" parent="LeftCheckArea"]
shape = SubResource( 4 )

[node name="RightCheckArea" type="Area2D" parent="."]
position = Vector2( 36, 0 )
collision_layer = 0
collision_mask = 2

[node name="RightCheckCollision" type="CollisionShape2D" parent="RightCheckArea"]
shape = SubResource( 4 )

[connection signal="accelDirChanged" from="." to="." method="_on_PlayerBody_accelDirChanged"]
[connection signal="body_entered" from="KickArea" to="." method="_on_KickArea_body_entered"]
[connection signal="body_exited" from="KickArea" to="." method="_on_KickArea_body_exited"]
[connection signal="body_entered" from="HurtArea" to="." method="_on_HurtArea_body_entered"]
[connection signal="body_exited" from="HurtArea" to="." method="_on_HurtArea_body_exited"]
[connection signal="body_entered" from="LeftCheckArea" to="." method="_on_LeftCheckArea_body_entered"]
[connection signal="body_exited" from="LeftCheckArea" to="." method="_on_LeftCheckArea_body_exited"]
[connection signal="body_entered" from="RightCheckArea" to="." method="_on_RightCheckArea_body_entered"]
[connection signal="body_exited" from="RightCheckArea" to="." method="_on_RightCheckArea_body_exited"]
              GDSC         +   �      ������������τ�   ������Ķ   �������Ķ���   ����ڶ��   ������������Ҷ��   ����ڶ��   ��������   �������϶���   ��������   ��������������Ҷ   �����������϶���   ��ڶ   ���������Ӷ�   ζ��   ���Ӷ���   ϶��   �������������Ӷ�   �涶                      2                                                    !   	   (   
   )      ,      -      4      8      9      ?      @      F      N      T      \      b      i      r      x      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   3YY;�  Y;�  �  Y;�  �  Y;�  �  Y;�  �  Y;�  �  Y;�  �  T�  YYB�	  YY0�
  P�  QV�  �  �  YY0�  PQV�  �  &�  V�  &�  T�  	�  V�  �  T�  �  �  &�  T�  �  V�  �  T�  �  �  '�  V�  &�  T�  �  V�  �  T�  �  �  &�  T�  	�  V�  �  T�  �  YY0�  PQV�  �  &�  P�  T�  Q�  V�  �  T�  �  P�  T�  Q�  �  (V�  �  T�  �  �  �  �  PQ�  �  �  �  T�  �  �  �  �  �  �  P�  R�  T�  QY`             GDSC            p      ��������������Ѷ   �����Ҷ�   ��ڶ   �������϶���   �����϶�   ����ڶ��   ��������   ���������������Ŷ���   �����׶�   ��������   ����϶��   ����϶��   ���Ӷ���   �����������������������Ҷ���   ���϶���   �����Ҷ�   ����������������������Ҷ   ����Ӷ��      Actor.gd         2                            
                           	      
   !      %      &      -      5      >      D      K      L      P      Q      R      Y      `      g      n      3YYY;LMYY0�  P�  QV�  �  �  YY0�  PQV�  �  �  �  �  �  YY0�  P�  QV�  &�  �  T�	  V�  &T�
  PQV�  )�  V�  �  T�  P�  Q�  �  �  PQYYY0�  P�  QV�  T�  P�  QY0�  P�  QV�  T�  P�  QY`   GDSC   D      �   �     ���Ҷ���   �������������Ķ�   ������������Ҷ��   ���������϶�   �����������׶���   �������ڶ���   ��������ڶ��   ����������Ҷ   �����������Ҷ���   ���������޶�   �����������Ŷ���   ����������ζ   ����������Ӷ   �������Ӷ���   �����������Ӷ���   ���������������Ӷ���   ��������   ��������   ���򶶶�   ����Ӷ��   ��������Ķ��   �����Ķ�   �����Ҷ�   ��ڶ   �������Ķ���   �������϶���   ����������������������¶   ���������������������¶�   ����������ڶ   �����ڶ�   ����������¶   �������ض���   ����������ٶ   ������������Ҷ��   ���Ӷ���   �����Ķ�   ζ��   ������������������ض   ��������������ض   ������Ķ   ����������Ӷ   ����������Ҷ���   �����������������Ӷ�   �����¶�   ������������϶��   �������Ķ���   �����ݶ�   �������Ķ���   �����������ض���   ����������Ķ   �����϶�   ����ڶ��   ����ڶ��   ��������   ����Ӷ��   ���������������Ŷ���   �������Ŷ���   �����׶�   ����������Ӷ   �����޶�   ���������������Ŷ���   ���Ӷ���    �����������������������������Ҷ�   ���϶���    ����������������������������Ҷ��    ���������������������������Ķ���   ��������������������������Ҷ    ����������������������������Ҷ��      Actor.gd          �      2      &     ,               EnemySprite       res://sprites/enemy.png       res://sprites/enemy_dead.png            died            accelDirChanged             detectedPlayer            `         playerEscaped                                              
                     	      
               !      &      +      ,      3      6      ;      D      E      M      U      V      Y      \      _      a      c      d      i      j       q   !   u   "   v   #   }   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   �   3   �   4   �   5   �   6   �   7   �   8   �   9   	  :     ;   (  <   0  =   5  >   6  ?   <  @   E  A   [  B   g  C   v  D     E   �  F   �  G   �  H   �  I   �  J   �  K   �  L   �  M   �  N   �  O   �  P   �  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   �  Y   �  Z   �  [   �  \   �  ]   �  ^     _     `     a     b     c     d   !  e   %  f   (  g   ,  h   /  i   1  j   5  k   6  l   7  m   >  n   B  o   I  p   M  q   N  r   O  s   U  t   Y  u   ]  v   a  w   b  x   c  y   i  z   m  {   q  |   u  }   v  ~   w     }  �   �  �   �  �   3YYYBYB�  YB�  YYY;�  Y;�  �  Y;�  �  Y;�  �  Y;�  �  Y;�  �  YY8P�  Q;�	  Y;�
  Y;�  �  Y5;�  �  P�  QYY;�  ?P�  QY;�  ?P�	  QYY>N�  �  R�  �  R�  �  YOYY;�  �  YY0�  P�  QV�  �  �  YY0�  P�  QV�  �  �  �  �  �  �  �  P�
  R�  Q�  �  P�
  R�  Q�  �  �  �  �  P�  QYY0�  PQV�  �  &�	  V�  ;�  �
  L�  M�  &�  T�   P�  Q	�!  V�  �  �1  P�  �  R�  R�
  T�"  PQQ�  �  �
  L�  M�  ;�#  �  P�  T�$  �  T�$  Q�  &�  �#  V�  �  �#  �  �  P�  Q�  �  �  &�  V�  &�  P�  T�%  PQT�$  �&  T�$  Q�'  V�  ;�(  �)  PQT�*  �  ;�+  �(  T�,  P�&  R�  T�%  PQRLMR�  Q�  &�+  T�-  �  V�  �  P�  QYY0�.  PQV�  ;�(  �)  PQT�*  �  ;�+  �(  T�,  P�&  R�  T�%  PQRLMR�  Q�  &�  P�+  T�-  �  QV�  ;�/  �  T�0  PQT�$  �  T�$  �  &�  P�/  Q�  V�  ;�#  �  P�/  Q�  &�  �#  V�  �  �#  �  �  P�  Q�  &�  T�1  PQV�  &�/  	�  V�  �  �  �  (V�  �  P�  QYY0�2  PQV�  �3  �  �  �!  �  �  �4  �  �  �5  �  �  �  &�	  V�  �
  �  P�	  QT�6  T�7  PQYY0�8  P�9  QV�  &�  �  V�  �  T�:  P�  Q�  (V�  �  T�:  P�  Q�  &�'  �  V�  �  T�;  �  �  '�'  �  V�  �  T�;  �  YY0�<  P�9  QV�  /�  V�  �  V�  �  PQ�  �  V�  �.  PQ�  �  V�  -�  �=  PQYYY0�>  P�?  QV�  �  �  Y0�@  P�?  QV�  �  �  YYY0�A  PQV�  �  �  �  �3  �  �  �!  �  YYY0�B  PQV�  �  �  �  �3  �  �  �!  �  YYY0�C  PQV�  &�  �  V�  �'  �  Y`              GDSC            U      ���Ӷ���   ���������޶�   ������Ŷ   �����������ض���   ���������������Ѷ���   ��������������Ҷ   �����϶�   ���Ӷ���   �����Ķ�   �������Ӷ���   ����϶��   ��������Ķ��   �������������Ҷ�   ����������ڶ                   enemiesDefeated                    
                                 	   '   
   (      0      6      =      >      D      H      N      S      3YY8P�  Q;�  Y5;�  �  PQY;�  YB�  YY0�  PQV�  �  �  T�  PQ�  �  ;�  �	  P�  Q�  )�
  �  V�  �
  T�  P�  QYY0�  PQV�  �  �  &�  �  V�  �  P�  QY`       GDSC   
         V      ���ׄ�   �����������׶���   ��������������Ҷ   ��ض   �������Ӷ���   �������������������Ӷ���   ������������������������Ҷ��   ���϶���   �����������������������Ҷ���   ��������������������������Ҷ             win                                                        !   	   "   
   )      -      1      5      6      =      A      B      H      L      P      T      3YY;�  Y;�  YY0�  PQV�  �?  P�  Q�  �  PQT�  PQYY0�  P�  QV�  �  �  �  &�  V�  �  PQYY0�  P�  QV�  �  YY0�	  PQV�  �  �  �  &�  V�  �  PQY`        GDSC            "      �����ׄ򶶶�   ���������϶�   �������Ӷ���   �������Ŷ���   �����׶�   �������ض���   ζ��   ������������������ض      /root/Level/Player                                              3YY5;�  �  PQYY0�  P�  QV�  �  T�  �  T�  PQT�  Y`        GDSC   D      �   �     ������������   ��������   ������������   ��������Ӷ��   ��������Ӷ��   �����ڶ�   ��������   ����������Ҷ   �������Ҷ���   ���ƶ���   �����Ҷ�   ���������Ҷ�   ���������������ڶ���   ����������������ڶ��   ��������Ŷ��   ��������������Ѷ   �����������Ӷ���   �������Ӷ���   �������׶���   ������������Ӷ��   ���������������������Ӷ�   ������������Ŷ��   ����¶��   ���������������������Ҷ�   �������Ķ���   ����������������������Ҷ   ����������������Ҷ��   ������Ķ   ��������ض��   ����϶��   ����������Ӷ   ���������޶�   ��Ӷ   �������Ӷ���   �������������������Ӷ���   ���������Ӷ�   �������϶���   ζ��   ������������Ҷ��   ����ڶ��   �����������������Ӷ�   �����϶�   ����ڶ��   �������Ŷ���   �����׶�   ���������������Ŷ���   ����������Ķ   �����������ض���   ���������������������¶�   ���������ڶ�   ϶��   ��������   ���������Ҷ�   ��������������ض   ������������������ض   �������Ӷ���   ���Ӷ���   ������������������������Ҷ��   ���϶���   �����Ҷ�   �����������������������Ҷ���   ����Ӷ��   ������������������������Ҷ��   �����������������������Ҷ���    ������������������������������Ҷ    �����������������������������Ҷ�    �����������������������������Ҷ�    ����������������������������Ҷ��      Actor.gd   (      <      F      �     �               PlayerSprite      KickArea      res://sprites/player.png   #   res://sprites/player_kick_ready.png       left            right                jump            drop      lose  333333�?   �      X     2                                         	                           	      
         &      '      ,      1      6      7      <      A      B      G      L      M      S      Y      Z      c      l      m      u      }      ~       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0   �   1   �   2   �   3   �   4   �   5   �   6     7     8   	  9     :     ;     <     =     >   "  ?   *  @   1  A   4  B   ;  C   A  D   H  E   O  F   V  G   W  H   ]  I   b  J   j  K   k  L   q  M   v  N   w  O   x  P   ~  Q   �  R   �  S   �  T   �  U   �  V   �  W   �  X   �  Y   �  Z   �  [   �  \   �  ]   �  ^   �  _   �  `   �  a   �  b   �  c   �  d   �  e   �  f   �  g   �  h   �  i     j     k     l     m     n     o     p     q   +  r   2  s   ?  t   @  u   A  v   H  w   L  x   S  y   W  z   X  {   Y  |   c  }   g  ~   k     l  �   m  �   u  �   y  �   }  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �   �  �     �     �     �     �     �     �     �     �     �     �   $  �   +  �   2  �   3  �   4  �   ;  �   B  �   I  �   P  �   Q  �   R  �   Y  �   ]  �   d  �   h  �   o  �   s  �   z  �   ~  �   3YYY;�  Y;�  �  Y;�  �  YY;�  �  Y;�  �  YY;�  �  T�  YY;�  �  Y;�  �  Y;�	  �  YY;�
  �  Y;�  �  YY;�  �  Y;�  �  YY;�  LMY;�  LMYY5;�  �  P�  QY5;�  �  P�  QYY;�  ?P�	  QY;�  ?P�
  QYY0�  PQV�  &�  T�  P�  QV�  �  �  �  &�  T�  P�  QV�  �  �  �  &�  T�  P�  QV�  &�  T�  P�  QV�  �  �  �  (V�  �  �  �  &�  T�  P�  QV�  &�  T�  P�  QV�  �  �  �  (V�  �  �  �  &�  �  V�  �  �  �  �  &�  T�  P�  QV�  �  �  �  (V�  �  �  �  &�  T�  P�  QV�  �  �  �  (V�  �  �  �  �  &�  T�  P�  QV�  �	  �  YY0�  PQV�  &�  T�  PQV�  �  T�  P�  Q�  (V�  �  T�  P�  Q�  &�  �  V�  �  T�  P�  Q�  '�  �  V�  �  T�  P�  QYY0�   PQV�  �?  P�  Q�  �!  PQT�"  PQYY0�#  PQV�  ;�  �$  �  �  �  &�  �  V�  &�  T�%  	�&  V�  �  T�%  �'  �  &�  T�%  �&  V�  �  T�%  �&  �  '�  �  V�  &�  T�%  �&  V�  �  T�%  �'  �  &�  T�%  	�&  V�  �  T�%  �&  �  �  &�
  V�  �$  �  �  (V�  �$  �$  T�(  P�  R�  QYY0�)  PQV�  �'  �  �  �&  �  �  �*  �  YY0�+  P�,  QV�  �  PQ�  �  PQYY0�-  P�,  QV�  �  &�  T�  PQV�  &�.  PQV�  �   PQ�  �  �  &�  �  V�  �  T�/  P�  P�  R�  QQ�  '�  �  V�  �  T�/  P�  P�  R�  QQ�  �  �  �0  P�  R�  Q�  &�	  V�  �0  P�  R�  Q�  �	  �  �  �  �  &�.  PQ�1  PQV�  �
  �  �  �  �  �  �  �  &�$  T�2  	�  V�  &�  V�  �3  �  (V�  �3  �  �  (V�  �3  �  �  �  �  &�  V�  �  &�.  PQV�  �$  T�2  �  �  �  (V�  �
  �  �  �  �  &�  V�  �$  �  P�  R�  QT�4  PQ�  �  '�  V�  �$  �  P�  R�  QT�4  PQ�  �  �  �  '�  V�  �  &�  T�  PQV�  �$  P�5  �  L�  MT�6  PQQT�4  PQ�  �  )�7  �  V�  �7  T�
  P�$  Q�  �  �  (V�  �  �  �  �8  PQYYYY0�9  P�:  QV�  �  T�;  P�:  QY0�<  P�:  QV�  �  T�=  P�:  QYYY0�>  P�:  QV�  �  T�;  P�:  QY0�?  P�:  QV�  �  T�=  P�:  QYYY0�@  P�:  QV�  �  �  Y0�A  P�:  QV�  �  �  Y0�B  P�:  QV�  �  �  Y0�C  P�:  QV�  �  �  Y`    GDST@   @             �   WEBPRIFF�   WEBPVP8L�   /?� 0��?�x�I���x�wjFiBi@�h3��|db�BD�'����x|��#���rK������H���eN�	�-�l�0����Rْڦ4lH�ZZV�6H4
���4G3�J���کW3͑V�]��h%mkiِ�MiؒڶTF	!I�6ض�a�6�en+��)�]��-}�����tz���-              [remap]

importer="texture"
type="StreamTexture"
path="res://.import/block.png-5bbcdacea06057fdfa5559fd03e54f2c.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/block.png"
dest_files=[ "res://.import/block.png-5bbcdacea06057fdfa5559fd03e54f2c.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
  GDST@   @             t   WEBPRIFFh   WEBPVP8L\   /?�  H��:I� �B�QcB���X���F�d�������H�1���1�����m�7〲d$�R�EI�v���f?�S���/6[remap]

importer="texture"
type="StreamTexture"
path="res://.import/enemy.png-03f80dfd1208a1b3024d79304d31759f.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/enemy.png"
dest_files=[ "res://.import/enemy.png-03f80dfd1208a1b3024d79304d31759f.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
  GDST@   @            n   WEBPRIFFb   WEBPVP8LV   /?�  H��:I� �B�QcB���X���Fm$9j<KbQ,�F���H���� � �m;]Q��R�!�e<��
���      [remap]

importer="texture"
type="StreamTexture"
path="res://.import/enemy_dead.png-29de2c2a30d987039d5c4be0a6f6a987.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/enemy_dead.png"
dest_files=[ "res://.import/enemy_dead.png-29de2c2a30d987039d5c4be0a6f6a987.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
    GDST@   @             <   WEBPRIFF0   WEBPVP8L$   /?� 0�#2L�xPԶS�e>n�_D�' ����p        [remap]

importer="texture"
type="StreamTexture"
path="res://.import/exit.png-f7467592b670edf91e317e4d1b376de1.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/exit.png"
dest_files=[ "res://.import/exit.png-f7467592b670edf91e317e4d1b376de1.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
  GDST@   @             �  WEBPRIFF�  WEBPVP8L�  /?����m��������_"�0@��^�"�v��s�}� �W��<f��Yn#I������wO���M`ҋ���N��m:�
��{-�4b7DԧQ��A �B�P��*B��v��
Q�-����^R�D���!(����T�B�*�*���%E["��M�\͆B�@�U$R�l)���{�B���@%P����g*Ųs�TP��a��dD
�6�9�UR�s����1ʲ�X�!�Ha�ߛ�$��N����i�a΁}c Rm��1��Q�c���fdB�5������J˚>>���s1��}����>����Y��?�TEDױ���s���\�T���4D����]ׯ�(aD��Ѓ!�a'\�G(��$+c$�|'�>����/B��c�v��_oH���9(l�fH������8��vV�m�^�|�m۶m�����q���k2�='���:_>��������á����-wӷU�x�˹�fa���������ӭ�M���SƷ7������|��v��v���m�d���ŝ,��L��Y��ݛ�X�\֣� ���{�#3���
�6������t`�
��t�4O��ǎ%����u[B�����O̲H��o߾��$���f���� �H��\��� �kߡ}�~$�f���N\�[�=�'��Nr:a���si����(9Lΰ���=����q-��W��LL%ɩ	��V����R)�=jM����d`�ԙHT�c���'ʦI��DD�R��C׶�&����|t Sw�|WV&�^��bt5WW,v�Ş�qf���+���Jf�t�s�-BG�t�"&�Ɗ����׵�Ջ�KL�2)gD� ���� NEƋ�R;k?.{L�$�y���{'��`��ٟ��i��{z�5��i������c���Z^�
h�+U�mC��b��J��uE�c�����h��}{�����i�'�9r�����ߨ򅿿��hR�Mt�Rb���C�DI��iZ�6i"�DN�3���J�zڷ#oL����Q �W��D@!'��;�� D*�K�J�%"�0�����pZԉO�A��b%�l�#��$A�W�A�*^i�$�%a��rvU5A�ɺ�'a<��&�DQ��r6ƈZC_B)�N�N(�����(z��y�&H�ض^��1Z4*,RQjԫ׶c����yq��4���?�R�����0�6f2Il9j��ZK�4���է�0؍è�ӈ�Uq�3�=[vQ�d$���±eϘA�����R�^��=%:�G�v��)�ǖ/��RcO���z .�ߺ��S&Q����o,X�`�����|��s�<3Z��lns'���vw���Y��>V����G�nuk:��5�U.�v��|����W���Z���4�@U3U�������|�r�?;�
         [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-82ea131e750a89467e27b5ff9b11ce77.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/icon.png"
dest_files=[ "res://.import/icon.png-82ea131e750a89467e27b5ff9b11ce77.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
     GDST                 :   WEBPRIFF.   WEBPVP8L!   /�� 0�3<��x  ��5�-�� �N�?�           [remap]

importer="texture"
type="StreamTexture"
path="res://.import/one_way_platform.png-1b8121d5bc3374479d8a0f5476f905b7.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/one_way_platform.png"
dest_files=[ "res://.import/one_way_platform.png-1b8121d5bc3374479d8a0f5476f905b7.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
 GDST@   @             �   WEBPRIFF�   WEBPVP8L}   /?�   ���2bCH@x������������OU��ƶ��*@�	jHE��#��X���W�E�W5L~O���nD�'R:4 E6�)�	9!��C҉�CRdj�>�2��->'��a�               [remap]

importer="texture"
type="StreamTexture"
path="res://.import/player.png-f534b8a02ffb80eefc72936296201445.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/player.png"
dest_files=[ "res://.import/player.png-f534b8a02ffb80eefc72936296201445.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
               GDST@   @             �   WEBPRIFF�   WEBPVP8L~   /?� ��m�^���<�@����	4���� ��Vশm'z$�xH���O�s<�T�E��LO�0��Q�|%�A�P��B*�R�A���u(B��
E7l9��.���L�/�              [remap]

importer="texture"
type="StreamTexture"
path="res://.import/player_kick_ready.png-254207c06b6dfd71e21c726a6bd82ec7.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/player_kick_ready.png"
dest_files=[ "res://.import/player_kick_ready.png-254207c06b6dfd71e21c726a6bd82ec7.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
              GDST@   @             &   WEBPRIFF   WEBPVP8L   /?� �DD�              [remap]

importer="texture"
type="StreamTexture"
path="res://.import/tile.png-c98d57e832a262fb2a654d7968b27450.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://sprites/tile.png"
dest_files=[ "res://.import/tile.png-c98d57e832a262fb2a654d7968b27450.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=false
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
     [remap]

path="res://scripts/Actor.gdc"
        [remap]

path="res://scripts/Block.gdc"
        [remap]

path="res://scripts/Enemy.gdc"
        [remap]

path="res://scripts/EnemyHandler.gdc"
 [remap]

path="res://scripts/Exit.gdc"
         [remap]

path="res://scripts/MainCamera.gdc"
   [remap]

path="res://scripts/Player.gdc"
       �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG      _global_script_classes�                     class         GitAPI        language      NativeScript      path   *   res://addons/godot-git-plugin/git_api.gdns        base          _global_script_class_icons                GitAPI            application/config/name         JumpKick   application/run/main_scene          res://scenes/Level.tscn    application/config/icon          res://sprites/icon.png     gdnative/singletons<            ,   res://addons/godot-git-plugin/git_api.gdnlib   input/right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   D      physical_scancode             unicode           echo          script      
   input/left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode   A      physical_scancode             unicode           echo          script      
   input/jump�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode          physical_scancode             unicode           echo          script      
   input/drop�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device            alt           shift             control           meta          command           pressed           scancode        physical_scancode             unicode           echo          script         layer_names/2d_physics/layer_1         player     layer_names/2d_physics/layer_2         solid      layer_names/2d_physics/layer_3         kickable   layer_names/2d_physics/layer_4         oneway     layer_names/2d_physics/layer_5         enemy   )   physics/common/enable_pause_aware_picking         )   rendering/environment/default_environment          res://default_env.tres          