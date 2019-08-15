# 
# Example file for parsing and processing XML
#
import xml.dom.minidom


def main():
    # use the parse() function to load and parse an XML file
    doc = xml.dom.minidom.parse('samplexml.xml')

    # print out the document node and the name of the first child tag
    print(doc.nodeName)
    print(doc._get_firstChild().tagName)

    # get a list of XML tags from the document and print each one
    skills = doc.getElementsByTagName('skill')
    print("{:d} skills: ".format(skills.length))
    for skill in skills:
        print(skill.getAttribute('name'))
    print('\n')

    # create a new XML tag and add it into the document
    new_skill = doc.createElement('skill')
    new_skill.setAttribute('name', 'Microsoft SQL Server 2016')
    doc._get_firstChild().appendChild(new_skill)

    skills = doc.getElementsByTagName('skill')
    print("{:d} skills: ".format(skills.length))
    for skill in skills:
        print(skill.getAttribute('name'))


if __name__ == "__main__":
    main()
