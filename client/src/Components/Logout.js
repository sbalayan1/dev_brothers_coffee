import {useEffect} from 'react'

let Logout = ({setCurrentUser}) => {
    useEffect(() => {
        fetch('/logout')
        .then(() => 
            setCurrentUser(null)
        )
    },[setCurrentUser])

    return (
        <div>
            Goodbye!
        </div>
    )

}

export default Logout