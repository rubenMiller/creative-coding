﻿using ImageMagick;
using OpenTK.Graphics.OpenGL4;
using System.IO;

namespace Zenseless.OpenTK;
using static SizedInternalFormat;

/// <summary>
/// Class for loading textures from images
/// </summary>
public static class Texture2DLoader
{
	/// <summary>
	/// Load a texture from the given stream.
	/// </summary>
	/// <param name="stream">A stream containing an image.</param>
	/// <param name="mipMap">Are mipmaps created.</param>
	/// <returns>A Texture.</returns>
	public static Texture2D Load(Stream stream, bool mipMap = true)
	{
		//TODO: Try out alternatives to magickimage
		using var image = new MagickImage(stream);
		return Load(image, mipMap);
	}

	/// <summary>
	/// Load a texture from the given <seealso cref="MagickImage"/>.
	/// </summary>
	/// <param name="image">A <seealso cref="MagickImage"/>.</param>
	/// <param name="mipMap">Are mipmaps created.</param>
	/// <returns>A Texture.</returns>
	public static Texture2D Load(MagickImage image, bool mipMap = true)
	{
		image.Flip();
		SizedInternalFormat internalFormat = Rgb8; // default rgb
		switch (image.ColorType)
		{
			case ColorType.TrueColorAlpha: internalFormat = Rgba8; break;
			case ColorType.Grayscale: internalFormat = R8; image.Grayscale(); break;
			case ColorType.PaletteAlpha: internalFormat = Rgba8; image.ColorType = ColorType.TrueColor; break;
			case ColorType.Palette: image.ColorType = ColorType.TrueColorAlpha; break;
		}
		var pixels = image.GetPixelsUnsafe().GetAreaPointer(0, 0, image.Width, image.Height);
		var texture = new Texture2D(image.Width, image.Height, internalFormat)
		{
			Function = TextureFunction.ClampToEdge,
			MagFilter = TextureMagFilter.Linear,
			MinFilter = mipMap ? TextureMinFilter.LinearMipmapLinear : TextureMinFilter.Linear
		};

		var format = TextureExtensions.PixelFormatFrom(internalFormat);
		GL.PixelStore(PixelStoreParameter.UnpackAlignment, 1); // some image sizes will cause memory acceptions otherwise
		GL.TextureSubImage2D(texture.Handle, 0, 0, 0, image.Width, image.Height, format, PixelType.UnsignedByte, pixels);

		if (mipMap) GL.GenerateTextureMipmap(texture.Handle);

		return texture;
	}
}
