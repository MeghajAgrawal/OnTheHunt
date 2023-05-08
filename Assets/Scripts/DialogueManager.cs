using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using Ink.Runtime;
using UnityEngine.EventSystems;


public class DialogueManager : MonoBehaviour
{

    [Header("Dialogue UI")]
    [SerializeField] private GameObject dialoguePanel;
    [SerializeField] private GameObject ContinueIcon;
    [SerializeField] private TextMeshProUGUI dialogueText;
    [SerializeField] private TextMeshProUGUI displayNameText;
    [SerializeField] private Image CharacterImage;

       
    [Header("Globals Ink JSON")]
    [SerializeField] private TextAsset LoadGlobalsJson;

    [Header("Choices UI")]
    [SerializeField] private GameObject[] choices;
    private TextMeshProUGUI[] choicesText;

    private Story currentStory;
    public bool dialogueIsPlaying { get; private set; }

    private bool canContinue = false;
    public float letterPause = 1.0f;


    private static DialogueManager instance;
    private DialogueVariables dialogueVariables;
    private Coroutine displayCoroutine;

    [Header("Character Image UI")]
    public Sprite AliImage;
    public Sprite JackImage;
    public Sprite BeatriceImage;    
    public Sprite MartyImage;
    public Sprite TutorialSpiritImage;
    private const string Speaker = "speaker";
    private const string Portrait = "portrait";

    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("Found more than one Dialogue Manager in the scene");
        }
        instance = this;

        dialogueVariables = new DialogueVariables(LoadGlobalsJson);
    }

    public static DialogueManager GetInstance()
    {
        return instance;
    }

    private void Start()
    {
        dialogueIsPlaying = false;
        dialoguePanel.SetActive(false);

        // get all of the choices text 
        choicesText = new TextMeshProUGUI[choices.Length];
        int index = 0;
        foreach (GameObject choice in choices)
        {
            choicesText[index] = choice.GetComponentInChildren<TextMeshProUGUI>();
            index++;
        }
    }

    private void Update()
    {
        // return right away if dialogue is playing
        if (!dialogueIsPlaying)
        {
            return;
        }

        // handle continuing to the next line in the dialogue when submit is pressed
        // NOTE: The 'currentStory.currentChoiecs.Count == 0' part was to fix a bug after the Youtube video was made
        if (canContinue && currentStory.currentChoices.Count == 0 &&Input.GetKeyUp(KeyCode.Space))
        {
            ContinueStory();
        }
    }

    public void EnterDialogueMode(TextAsset inkJSON)
    {
        currentStory = new Story(inkJSON.text);
        dialogueIsPlaying = true;
        dialoguePanel.SetActive(true);

        dialogueVariables.StartListening(currentStory);
        displayNameText.text = "???";

        ContinueStory();
    }

    private void ContinueStory()
    {
        if (currentStory.canContinue)
        {
            // set text for the current dialogue line
            // dialogueText.text = currentStory.Continue();
            if(displayCoroutine != null)
            {
                StopCoroutine(displayCoroutine);
            }
            displayCoroutine = StartCoroutine(TypeSentence(currentStory.Continue()));
            // display choices, if any, for this dialogue line
            
            HandleTags(currentStory.currentTags);
        }
        else
        {
            StartCoroutine(ExitDialogueMode());
        }
    }

    IEnumerator TypeSentence(string sentence)
    {
        canContinue = false;
        dialogueText.text = sentence;
        dialogueText.maxVisibleCharacters = 0;
        ContinueIcon.SetActive(false);
        HideChoices();
        foreach(char letter in sentence.ToCharArray())
        {
            if(Input.GetKeyDown(KeyCode.Space))
            {
                dialogueText.maxVisibleCharacters = sentence.Length;
                break;
            }
            dialogueText.maxVisibleCharacters++;
            yield return new WaitForSeconds(letterPause);
        }
        ContinueIcon.SetActive(true);
        DisplayChoices();
        canContinue = true;
    }

    private IEnumerator ExitDialogueMode()
    {
        yield return new WaitForSeconds(0.2f);

        dialogueVariables.StopListening(currentStory);

        dialogueIsPlaying = false;
        dialoguePanel.SetActive(false);
        dialogueText.text = "";
    }
    
    private void DisplayChoices()
    {
        List<Choice> currentChoices = currentStory.currentChoices;

        // defensive check to make sure our UI can support the number of choices coming in
        if (currentChoices.Count > choices.Length)
        {
            Debug.LogError("More choices were given than the UI can support. Number of choices given: "
                + currentChoices.Count);
        }

        int index = 0;
        // enable and initialize the choices up to the amount of choices for this line of dialogue
        foreach (Choice choice in currentChoices)
        {
            choices[index].gameObject.SetActive(true);
            choicesText[index].text = choice.text;
            index++;
        }
        // go through the remaining choices the UI supports and make sure they're hidden
        for (int i = index; i < choices.Length; i++)
        {
            choices[i].gameObject.SetActive(false);
        }

        StartCoroutine(SelectFirstChoice());
    }
    private void HideChoices()
    {
        foreach(GameObject choice in choices){
            choice.SetActive(false);
        }
    }
    private IEnumerator SelectFirstChoice()
    {
        // Event System requires we clear it first, then wait
        // for at least one frame before we set the current selected object.
        EventSystem.current.SetSelectedGameObject(null);
        yield return new WaitForEndOfFrame();
        EventSystem.current.SetSelectedGameObject(choices[0].gameObject);
    }

    public void MakeChoice(int choiceIndex)
    {
        if(canContinue)
        {
            currentStory.ChooseChoiceIndex(choiceIndex);
        // NOTE: The below two lines were added to fix a bug after the Youtube video was made
        //InputManager.GetInstance().RegisterSubmitPressed(); // this is specific to my InputManager script
            ContinueStory();
        }
        
    }

    public Ink.Runtime.Object GetVariableState(string variableName)
    {
        Ink.Runtime.Object variableValue = null;
        dialogueVariables.variables.TryGetValue(variableName, out variableValue);
        if(variableValue == null)
        {
            print("Does not exist");
        }
        return variableValue;
    }
    private void HandleTags(List<string> currentTags)
    {
        foreach (string tag in currentTags)
        {
            string[] splitTag = tag.Split(':');
            if(splitTag.Length !=2)
            {
                print("Error");
            }
            string tagKey = splitTag[0].Trim();
            string tagVal = splitTag[1].Trim();
            switch(tagKey)
            {
                case Speaker:
                    displayNameText.text = tagVal;
                    break;
                case Portrait:
                    switch (tagVal)
                    {
                        case "Ali":
                            CharacterImage.sprite = AliImage;
                        break;
                        case "Jack":
                            CharacterImage.sprite = JackImage;
                        break;
                        case "Beatrice":
                            CharacterImage.sprite = BeatriceImage;
                        break;
                        case "Marty":
                            CharacterImage.sprite = MartyImage;
                        break;
                        case "TutorialSpirit":
                            CharacterImage.sprite = TutorialSpiritImage;
                            break;
                        default:
                        break;
                    }
                    break;
            }    
        }
        
    }
    
    public void OnApplicationQuit()
    {
        if(dialogueVariables !=null)
        {
            dialogueVariables.SaveVariables();
        }
    }
}