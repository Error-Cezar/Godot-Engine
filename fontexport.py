import os
from PIL import Image, ImageDraw, ImageFont

def extract_characters(font_path: str, output_folder: str, scale=40):
    # Specify the font file and size
    font_size = scale
    W, H = font_size, font_size
    
    if not font_path: print("font_path expected as argument 1"); return
    if not output_folder: print("output_folder expected as argument 2"); return
    font = ImageFont.truetype(font_path, font_size)

    # Specify the characters you want to extract
    characters = """ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.:,;'"(!?+-*/=)"""
    print(characters)
    
    for char in characters:
        # Create a new image with a white background
        img = Image.new('RGBA', (font_size, font_size))
        draw = ImageDraw.Draw(img)
        _, _, TW, TH = font.getbbox(char)
        # Draw the character on the image
        draw.text(( (W-TW)//2, (H - TH)//1 ), char, font=font, fill='white')

        # Save the image
        img.save(f'{output_folder}/{ord(char)}.png', 'PNG')

if __name__ == "__main__":
    Whitelist = [".ttf"]
    fonts = 'C:/Users/mobil/Documents/GitHub/Godot-Engine/Resources/Fonts'

    print("Running Under =>", fonts) 
    for filename in os.listdir(fonts):
        folder = fonts + "/" + os.path.splitext(filename)[0]
        fontpath = fonts + "/" + filename
        extension = os.path.splitext(filename)[1]
        if not extension in Whitelist: continue
        print("checking =>", folder)
        if not os.path.exists(folder):
            print("creating =>", folder)
            os.makedirs(folder)
        else:
            print("Skipping =>", filename)
            continue
        print("Exporting...")
        extract_characters(fontpath, folder)
        print("Finished =>", filename)
print("Task Completed")