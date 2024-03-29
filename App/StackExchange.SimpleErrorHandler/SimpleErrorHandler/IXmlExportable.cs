namespace SimpleErrorHandler
{    
    using System;
    using XmlWriter = System.Xml.XmlWriter;
    using XmlReader = System.Xml.XmlReader;

    /// <summary>
    /// Defines methods to convert an object to and from its XML representation.
    /// </summary>
    public interface IXmlExportable
    {
        /// <summary>
        /// Reads the object state from its XML representation.
        /// </summary>
        void FromXml(XmlReader r);

        /// <summary>
        /// Writes the XML representation of the object.
        /// </summary>
        void ToXml(XmlWriter w);
    }
}
