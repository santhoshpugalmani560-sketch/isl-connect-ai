from pygltflib import GLTF2
from pathlib import Path

files = [
    Path("assets/models/ISL_character.glb"),
    Path("assets/animations/Good_morning_animation_11.glb"),
]

for file in files:
    print("\n" + "=" * 55)
    print("FILE:", file)

    if not file.exists():
        print("ERROR: File not found")
        continue

    gltf = GLTF2().load(str(file))

    print("Nodes:", len(gltf.nodes or []))
    print("Meshes:", len(gltf.meshes or []))
    print("Skins:", len(gltf.skins or []))
    print("Animations:", len(gltf.animations or []))

    for index, animation in enumerate(gltf.animations or []):
        print(f"\nAnimation {index + 1}: {animation.name or 'Unnamed'}")
        print("Channels:", len(animation.channels or []))
        print("Samplers:", len(animation.samplers or []))