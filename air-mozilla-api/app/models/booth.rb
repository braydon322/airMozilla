require 'open-uri'
require 'nokogiri'
require 'json'
require 'net/http'
require 'uri'

class Booth < ApplicationRecord

  def self.getData()
      url = 'https://api.onlinexperiences.com/scripts/Server.nxp?LASCmd=AI:4;F:APIUTILS!50540&APIUserCredentials=vi7ciuslap8las71adoepleth5uyIa&APIUserAuthCode=chiathlunletrieswle5oaproableS&OpCodeList=EEL&OutputFormat=X&ShowKey=44908'
      result = Nokogiri.XML(open(url).read)
      webinarNodes = result.children.children[0].elements

      webinarNodes.each do |webinarNode|
        title = webinarNode.children[1].text
        summary = webinarNode.children[3].text

        if webinarNode.children[8].text.include? 'https://content.onlinexperiences.com'
          picon = webinarNode.children[8].text
        else
          picon = 'https://content.onlinexperiences.com' + webinarNode.children[8].text
        end

        registration = webinarNode.children[9].text.to_i
        eventKey = webinarNode.children[0].text
        date = ''

        @webinar = Webinar.find_or_create_by(:title => title, :favicon => picon, :date => date, :url => eventKey)
      end
  end

  def self.getToken(webinar)
    deleteUser = 'https://api.onlinexperiences.com/scripts/Server.nxp?LASCmd=AI:4;F:APIUTILS!50500&APIUserAuthCode=chiathlunletrieswle5oaproableS&APIUserCredentials=vi7ciuslap8las71adoepleth5uyIa&OpCodeList=@&OutputFormat=X&EMailAddress=public@public.com'
    createUser = 'https://api.onlinexperiences.com/scripts/Server.nxp?LASCmd=AI:4;F:APIUTILS!50500&APIUserAuthCode=chiathlunletrieswle5oaproableS&APIUserCredentials=vi7ciuslap8las71adoepleth5uyIa&OpCodeList=I&OutputFormat=X&EMailAddress=public@public.com'
    findUser = 'https://api.onlinexperiences.com/scripts/Server.nxp?LASCmd=AI:4;F:APIUTILS!50500&APIUserAuthCode=chiathlunletrieswle5oaproableS&APIUserCredentials=vi7ciuslap8las71adoepleth5uyIa&OpCodeList=G&OutputFormat=X&EMailAddress=public@public.com'
    userDeleted = Nokogiri.XML(open(deleteUser).read)
    userCreated = Nokogiri.XML(open(createUser).read)
    userFound = Nokogiri.XML(open(findUser).read)
    showUserKey = userFound.children.children.children[0].elements[0].text

    # if (webinar.url.size >= 7)
    #     debugger
    # end

    generateToken = 'https://onlinexperiences.com/scripts/Server.nxp?LASCmd=AI:4;F:APIUTILS!50500&APIUserAuthCode=chiathlunletrieswle5oaproableS&APIUserCredentials=vi7ciuslap8las71adoepleth5uyIa&EMailAddress=public@public.com&OpCodeList=T&OutputFormat=T&ShowLaunchInitialDisplayItem=E' + webinar.url + '&ShowKey=44908'

    token = open(generateToken).read
    tokenArray = token.split("\r\n")
    updatedToken = tokenArray[3]

    urlWithToken = 'https://api.onlinexperiences.com/scripts/Server.nxp?LASCmd=AI:4;F:APIUTILS!50505&LoginTicketKey=' + updatedToken

    @token = Token.create(:token => updatedToken, :loginTicketURL => urlWithToken)

    return @token
  end

end
