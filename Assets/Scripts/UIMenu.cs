using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;
public class UIMenu : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject PausePanel;
    public GameObject GameOverPanel;
    public GameObject CoinHolder;
    string SistineText = "Your journey now led you to the Sistine Chapel, where you spend hours trying to find answers or any clues which could lead you to the awaiting riches unfortunately following the map did not work and you curse yourself for using substitute items ";
    string VaticanText = "Your journey now led you to the Vatican Library, where you speak to a Pope who instantly recognizes the symbol on the map. You hurry along side the pope to the destination and find a deep hidden room. Following the map into the cavern, you became the first to rediscover the long-lost Vatican Gold";
    string LostText = "You could not get the map restored, and have to stay in town and wait";
    string winConvalue = "WinCondition";
    public TextMeshProUGUI WinText;
    // Update is called once per frame
    void Update()
    {  
        if(Input.GetKeyUp(KeyCode.Escape))
        {
            PausePanel.SetActive(true);
            Time.timeScale = 0;
        }

        Ink.Runtime.Object value =  DialogueManager.GetInstance().GetVariableState(winConvalue);
        Ink.Runtime.Object endvalue =  DialogueManager.GetInstance().GetVariableState("end");
        if(endvalue.ToString() == "end" && !DialogueManager.GetInstance().dialogueIsPlaying)
        {
            if(value!=null)
            {
                switch(value.ToString())
                {
                    case "Sistine":
                        GameOver(SistineText,false);
                    break;
                    case "Vatican":
                        GameOver(VaticanText,false);
                    break;
                    case "LostGame":
                        GameOver(LostText,true);
                    break;
                    default : break;
                }
            }
        }
    }
    
    public void Resume()
    {
        Time.timeScale = 1;
        PausePanel.SetActive(false);
    }
    public void MainMenu()
    {
        SceneManager.LoadScene(0);
    }
    public void restart()
    {
        SceneManager.LoadScene(1);
    }
    public void GameOver(string value,bool settext)
    {
        Time.timeScale = 0;
        GameOverPanel.SetActive(true);
        CoinHolder.SetActive(false);
        if(settext)
        {
            Ink.Runtime.Object item1quantity =  DialogueManager.GetInstance().GetVariableState("item1quantity");
            Ink.Runtime.Object item2quantity =  DialogueManager.GetInstance().GetVariableState("item2quantity");
            Ink.Runtime.Object item3quantity =  DialogueManager.GetInstance().GetVariableState("item3quantity");
            if(item2quantity.ToString().Equals("0") && item3quantity.ToString().Equals("0"))
            {
                value = value + " for Jack to sober up and Marty to calm down to buy the required materials";
            }
            else
            {
                if(item2quantity.ToString().Equals("0"))
                {
                    value = value + " for Jack to sober up to buy the required materials";
                }
                else if(item3quantity.ToString().Equals("0"))
                {
                    value = value + " for Marty to calm down to buy the required materials";
                }
                else{}
            }
        }
        WinText.text = value;
    }

}
